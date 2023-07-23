# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
describe 'Articles Requests' do
  let!(:user) { create(:user, :confirmed) }

  context 'Success' do
    let!(:params) do
      {
        article: {
          title: 'This is the title',
          body: 'This is the body',
          user_id: user.id
        }
      }
    end

    it 'creates an article' do
      sign_in(user)
      expect(Article.count).to eq(0)
      post api_v1_articles_path, params: params
      expect(status).to eq(200)
      expect(json[:title]).to eq('This is the title')
      expect(Article.count).to eq(1)
      expect(user.articles).to include(Article.first)
    end
  end

  context 'Failure (With Validation Errors)' do
    let!(:params) do
      {
        article: {
          user_id: user.id
        }
      }
    end

    it 'creates an article' do
      sign_in(user)
      expect(Article.count).to eq(0)
      post api_v1_articles_path, params: params
      expect(status).to eq(422)
      expect(Article.count).to eq(0)
      expect(json[:errors]).to include("Title can't be blank")
      expect(json[:errors]).to include("Body can't be blank")
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

    it 'creates an article' do
      expect(Article.count).to eq(0)
      post api_v1_articles_path, params: params
      expect(status).to eq(401)
      expect(Article.count).to eq(0)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
    end
  end
end
# rubocop: enable Metrics/BlockLength
