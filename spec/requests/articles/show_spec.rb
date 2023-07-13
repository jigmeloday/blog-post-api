# frozen_string_literal: true

require 'rails_helper'

describe 'Articles Requests' do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  context 'Success' do

    it 'show article with user' do
      sign_in(user)
      expect(Article.count).to eq(1)
      get api_v1_article_path(article.id)
      expect(status).to eq(200)
      expect(Article.count).to eq(1)
    end

    it 'shows articles without user' do
      expect(Article.count).to eq(1)
      get api_v1_article_path(article.id)
      expect(status).to eq(200)
      expect(Article.count).to eq(1)
    end
  end
end
