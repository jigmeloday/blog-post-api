# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
describe 'Like' do
  let!(:user) { create(:user, :confirmed) }
  let!(:article) { create(:article, user: user) }
  let!(:comment) { create(:comment, user: user, commentable: article) }

  context 'Success On Article Liked' do
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
      article.reload
      expect(article.like_count).to eq(1)
      expect(Like.first.likable).to eq(Article.first)
    end
  end

  context 'Success on Comment Liked' do
    let!(:params) do
      {
        like: {
          likable_id: comment.id,
          likable_type: 'Comment'
        }
      }
    end

    it 'creates a like' do
      sign_in(user)
      expect(Like.count).to eq(0)
      post api_v1_likes_path, params: params
      expect(status).to eq(200)
      expect(Like.count).to eq(1)
      comment.reload
      expect(comment.like_count).to eq(1)
      expect(Like.first.likable).to eq(Comment.first)
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

  context 'Failure (With liking same post)' do
    let!(:like) { create(:like, likable: article, user: user) }
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
      expect(Like.count).to eq(1)
      post api_v1_likes_path, params: params
      expect(status).to eq(422)
      expect(Like.count).to eq(1)
      expect(json[:errors]).to include('User has already liked it!')
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
