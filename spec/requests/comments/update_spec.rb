# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
describe 'Comment' do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comment) { create(:comment, commentable: article, user: user) }

  context 'Success' do
    let!(:params) do
      {
        comment: {
          commentable_id: article.id,
          commentable_type: 'Article',
          body: 'Updated body',
          user_id: user.id
        }
      }
    end
    it 'update comment' do
      sign_in(user)
      expect(Comment.count).to eq(1)
      put api_v1_comment_path(comment.id), params: params
      expect(status).to eq(200)
      expect(Comment.count).to eq(1)
      expect(json[:body]).to eq('Updated body')
      article.reload
      expect(article.comment_count).to eq(1)
    end
  end

  context 'Failure (With wrong ID)' do
    let!(:params) do
      {
        comment: {
          commentable_id: article.id,
          commentable_type: 'Article',
          body: 'Updated body',
          user_id: user.id
        }
      }
    end
    it 'update comment with wrong id' do
      sign_in(user)
      expect(Comment.count).to eq(1)
      put api_v1_comment_path(0), params: params
      expect(status).to eq(404)
      expect(Comment.count).to eq(1)
      article.reload
      expect(article.comment_count).to eq(1)
    end
  end

  # context 'Failure (With Empty Body)' do
  #   let!(:params) do
  #     {
  #       comment: {
  #         commentable_id: article.id,
  #         commentable_type: 'Article',
  #         user_id: user.id
  #       }
  #     }
  #   end
  #   it 'update comment without body' do
  #     sign_in(user)
  #     expect(Comment.count).to eq(1)
  #     put api_v1_comment_path(comment.id), params: params
  #     expect(status).to eq(422)
  #     expect(Comment.count).to eq(1)
  #     article.reload
  #     expect(article.comment_count).to eq(1)
  #   end
  # end

  context 'Failure (With Diff User)' do
    let!(:user1) { create(:user) }
    let!(:params) do
      {
        comment: {
          commentable_id: article.id,
          commentable_type: 'Article',
          body: 'Updated body',
          user_id: user.id
        }
      }
    end
    it 'with different user' do
      sign_in(user1)
      expect(Comment.count).to eq(1)
      put api_v1_comment_path(comment.id), params: params
      expect(status).to eq(403)
      expect(Comment.count).to eq(1)
      article.reload
      expect(article.comment_count).to eq(1)
    end
  end

  context 'Failure (Without Signing in)' do
    let!(:params) do
      {
        comment: {
          commentable_id: article.id,
          commentable_type: 'Article',
          body: 'Updated body',
          user_id: user.id
        }
      }
    end
    it 'without user' do
      expect(Comment.count).to eq(1)
      put api_v1_comment_path(comment.id), params: params
      expect(status).to eq(401)
      expect(Comment.count).to eq(1)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
      article.reload
      expect(article.comment_count).to eq(1)
    end
  end
end
# rubocop: enable  Metrics/BlockLength
