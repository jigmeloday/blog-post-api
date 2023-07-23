# frozen_string_literal: true

require 'rails_helper'

describe 'Articles Requests' do
  let!(:user) { create(:user, :confirmed) }
  let!(:article) { create(:article, user: user) }

  context 'Success' do
    it 'show an article with user' do
      sign_in(user)
      expect(Article.count).to eq(1)
      get api_v1_articles_path
      expect(status).to eq(200)
      expect(Article.count).to eq(1)
      response_body = JSON.parse(response.body)
      expect(response_body).to be_an(Array)
    end

    it 'show an article without user' do
      expect(Article.count).to eq(1)
      get api_v1_articles_path
      expect(status).to eq(200)
      expect(Article.count).to eq(1)
    end
  end
end
