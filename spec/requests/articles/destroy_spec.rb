# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
describe 'Articles Requests' do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  context 'Success' do
    it 'delete an article' do
      sign_in(user)
      expect(Article.count).to eq(1)
      delete api_v1_article_path(article)
      expect(status).to eq(200)
      expect(Article.count).to eq(0)
    end
  end

  context 'Failure (With Validation Errors)' do

    it 'delete an article' do
      sign_in(user)
      expect(Article.count).to eq(1)
      delete api_v1_article_path(0)
      expect(status).to eq(404)
      expect(Article.count).to eq(1)
    end
  end

  context 'Failure (Without Signing in)' do

    it 'creates an article' do
      expect(Article.count).to eq(1)
      delete api_v1_article_path(article)
      expect(status).to eq(401)
      expect(Article.count).to eq(1)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
    end
  end
end
# rubocop: enable Metrics/BlockLength