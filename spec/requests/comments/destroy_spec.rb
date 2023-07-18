# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
describe 'Comment' do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comment) { create(:comment, commentable: article, user: user) }

  context 'Success' do
    it 'destroy comment' do
      sign_in(user)
      expect(Comment.count).to eq(1)
      delete api_v1_comment_path(comment.id)
      expect(status).to eq(200)
      expect(Comment.count).to eq(0)
      article.reload
      expect(article.comment_count).to eq(0)
    end
  end

  context 'Failure (With wrong ID)' do
    it 'destroy comment with wrong id' do
      sign_in(user)
      expect(Comment.count).to eq(1)
      post api_v1_comments_path(0)
      expect(status).to eq(400)
      expect(Comment.count).to eq(1)
      article.reload
      expect(article.comment_count).to eq(1)
    end
  end

  context 'Failure (Without Signing in)' do
    it 'without user' do
      expect(Comment.count).to eq(1)
      delete api_v1_comment_path(comment.id)
      expect(status).to eq(401)
      expect(Comment.count).to eq(1)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
      article.reload
      expect(article.comment_count).to eq(1)
    end
  end
end
# rubocop: enable  Metrics/BlockLength
