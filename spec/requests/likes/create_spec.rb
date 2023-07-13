# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
describe 'Like' do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  context 'Success' do
    let!(:params) do
      {
        like: {
          likable_id: article.id,
          likable_type: 'Article'
        }
      }
    end

    it 'creates a like' do
      sign_in(user)
      expect(Like.count).to eq(0)
      post api_v1_likes_path, params: params
      expect(status).to eq(200)
      expect(Like.count).to eq(1)
      expect(Like.first.likable).to eq(Article.first)
    end
  end

  context 'Failure (With Validation Errors)' do
    let!(:params) do
      {
        like: {
          likable_id: 1,
          likable_type: 'Article'
        }
      }
    end

    it 'creates a like' do
      sign_in(user)
      expect(Like.count).to eq(0)
      post api_v1_likes_path, params: params
      expect(status).to eq(422)
      expect(Like.count).to eq(0)
      expect(json[:errors]).to include('Likable must exist')
    end
  end

  context 'Failure (Without Signing in)' do
    let!(:params) do
      {
        like: {
          likable_id: article.id,
          likable_type: 'Article'
        }
      }
    end

    it 'creates a like' do
      expect(Like.count).to eq(0)
      post api_v1_likes_path, params: params
      expect(status).to eq(401)
      expect(Like.count).to eq(0)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
    end
  end
end
# rubocop: enable Metrics/BlockLength
