# frozen_string_literal: true

require 'rails_helper'

describe 'User Requests' do
  let!(:user) { create(:user, :confirmed, follower_count: 10) }
  let!(:user1) { create(:user, :confirmed, follower_count: 5) }
  let!(:user2) { create(:user, :confirmed, follower_count: 1) }

  context 'Success' do
    it 'show an highest follower user' do
      expect(User.count).to eq(3)
      get api_v1_users_path
      expect(status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body).to be_an(Array)
      assert_equal([10, 5, 1], response_body.map { |user| user['follower_count'] })
    end
  end
end
