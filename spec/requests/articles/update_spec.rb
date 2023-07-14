# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
describe 'Articles Requests' do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  context 'Success' do
    let!(:params) do
      {
        article: {
          title: 'This is the updated title',
          body: 'This is the updated body',
          user_id: user.id
        }
      }
    end

    it 'update an article' do
      sign_in(user)
      expect(Article.count).to eq(1)
      put api_v1_article_path(article), params: params
      expect(status).to eq(200)
      expect(json[:title]).to eq('This is the updated title')
      expect(Article.count).to eq(1)
      expect(user.articles).to include(Article.first)
    end
  end

  context 'Failure (With Validation Errors)' do
    let!(:params) do
      {
        article: {
          user_id: user.id,
          body: ''
        }
      }
    end

    it 'update an article' do
      sign_in(user)
      expect(Article.count).to eq(1)
      put api_v1_article_path(article), params: params
      expect(status).to eq(422)
      expect(Article.count).to eq(1)
      expect(article.reload.title).not_to eq('')
      expect(json[:errors]).to include("Body can't be blank")
    end
  end

  context 'Failure (With different user)' do
    let!(:user1) { create(:user) }
    let!(:params) do
      {
        article: {
          user_id: user.id
        }
      }
    end

    it 'update an article by different user' do
      sign_in(user1)
      expect(Article.count).to eq(1)
      put api_v1_article_path(article), params: params
      expect(status).to eq(403)
      expect(Article.count).to eq(1)
      # expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  context 'Failure (Without Signing in)' do
    let!(:params) do
      {
        article: {
          user_id: user.id
        }
      }
    end

    it 'update an article' do
      expect(Article.count).to eq(1)
      put api_v1_article_path(article), params: params
      expect(status).to eq(401)
      expect(Article.count).to eq(1)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
    end
  end
end
# rubocop: enable Metrics/BlockLength
