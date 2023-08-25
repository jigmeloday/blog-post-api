# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable  Metrics/BlockLength
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

    it 'returns the top 3 articles ordered by like_count' do
      article1 = create(:article, like_count: 10, user: user)
      article2 = create(:article, like_count: 5, user: user)
      article3 = create(:article, like_count: 8, user: user)

      get api_v1_popular_articles_path
      expect(status).to eq(200)
      response_json = JSON.parse(response.body)
      expect(response_json.length).to eq(3)
      expect(response_json[0]['like_count']).to be >= response_json[1]['like_count']
      expect(response_json[1]['like_count']).to be >= response_json[2]['like_count']
      expect(response_json.map { |a| a['id'] }).to eq([article1.id, article3.id, article2.id])
    end
  end
end
# rubocop: enable Metrics/BlockLength
