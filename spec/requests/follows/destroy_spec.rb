# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
describe 'Unfollow' do
  let!(:user) { create(:user) }
  let!(:user1) { create(:user) }

  context 'Success' do
    let!(:follow) { create(:follow, followed_user: user1, user: user) }
    let!(:params) do
      {
        follow: {
          followed_user_id: user1.id,
          user: user.id
        }
      }
    end

    it 'unfollow user' do
      sign_in(user)
      expect(Follow.count).to eq(1)
      delete api_v1_follow_path(user1.id), params: params
      expect(status).to eq(200)
      expect(Follow.count).to eq(0)
      expect(json[:message]).to eq(true)
      user1.reload
      expect(user1.follower_count).to eq(0)
    end
  end

  context 'Failure (With Validation Errors)' do
    let!(:params) do
      {
        follow: {
          followed_user_id: user1.id,
          user: user.id
        }
      }
    end

    it 'unfollow user' do
      sign_in(user)
      expect(Follow.count).to eq(0)
      delete api_v1_follow_path(user1.id), params: params
      expect(status).to eq(404)
      expect(Follow.count).to eq(0)
    end
  end
  context 'Failure (With invalid params)' do
    let!(:params) do
      {
        follow: {
          user: user.id
        }
      }
    end

    it 'unfollow user without followed_id' do
      expect(Follow.count).to eq(0)
      post api_v1_articles_path, params: params
      expect(status).to eq(401)
      expect(Follow.count).to eq(0)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  context 'Failure (Without Signing in)' do
    let!(:follow) { create(:follow, followed_user: user1, user: user) }
    let!(:params) do
      {
        follow: {
          followed_user_id: user1.id,
          user: user.id
        }
      }
    end

    it 'unfollow user' do
      expect(Follow.count).to eq(1)
      delete api_v1_follow_path(user1.id), params: params
      expect(status).to eq(401)
      expect(Follow.count).to eq(1)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  context 'Failure (Self Unfollow)' do
    let!(:follow) { create(:follow, followed_user: user1, user: user) }

    let!(:params) do
      {
        follow: {
          followed_user_id: user1.id,
          user: user1.id
        }
      }
    end
    it 'is invalid if a user tries to unfollow themselves' do
      sign_in(user1)
      expect(Follow.count).to eq(1)
      delete api_v1_follow_path(user1.id), params: params
      expect(Follow.count).to eq(1)
    end
  end
end
# rubocop: enable Metrics/BlockLength
