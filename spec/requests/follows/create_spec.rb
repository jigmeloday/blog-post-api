# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
describe 'Follow' do
  let!(:user) { create(:user) }
  let!(:user1) { create(:user) }

  context 'Success' do
    let!(:params) do
      {
        follow: {
          followed_user_id: user1.id,
          user: user.id
        }
      }
    end

    it 'follow user' do
      sign_in(user)
      expect(Follow.count).to eq(0)
      post api_v1_follows_path, params: params
      expect(status).to eq(200)
      expect(Follow.count).to eq(1)
      expect(json[:message]).to eq(true)
      user1.reload
      expect(user1.follower_count).to eq(1)
    end
  end

  context 'Failure (With Validation Errors)' do
    let!(:follow) { create(:follow, followed_user: user1, user: user) }
    let!(:params) do
      {
        follow: {
          followed_user_id: user1.id,
          user: user.id
        }
      }
    end

    it 'follow user' do
      sign_in(user)
      expect(Follow.count).to eq(1)
      post api_v1_follows_path, params: params
      expect(status).to eq(422)
      expect(Follow.count).to eq(1)
    end
  end

  # context  do
  #   it 'is invalid if a user tries to follow themselves' do
  #     self_follow = Follow.new(user: user, followed_user: user)
  #     expect(self_follow).not_to be_valid
  #     expect(self_follow.errors[:user_id]).to include('cannot follow themselves')
  #   end
  # end

  context 'Failure (With invalid params)' do
    let!(:params) do
      {
        follow: {
          user: user.id
        }
      }
    end

    it 'follow user without followed_id' do
      expect(Follow.count).to eq(0)
      post api_v1_articles_path, params: params
      expect(status).to eq(401)
      expect(Follow.count).to eq(0)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  context 'Failure (Without Signing in)' do
    let!(:params) do
      {
        follow: {
          followed_user_id: user1.id,
          user: user.id
        }
      }
    end

    it 'follow user' do
      expect(Follow.count).to eq(0)
      post api_v1_articles_path, params: params
      expect(status).to eq(401)
      expect(Follow.count).to eq(0)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
    end
  end
end
# rubocop: enable Metrics/BlockLength
