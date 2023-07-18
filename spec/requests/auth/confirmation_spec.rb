require 'rails_helper'

describe 'Confirmation' do
  context 'Success' do
    let!(:user) { create(:user) }

    it 'confirms' do
      expect(user.confirmed_at).to be_nil
      get user_confirmation_path, params: { confirmation_token: user.confirmation_token }
      expect(status).to eq(200)
      user.reload
      expect(user.confirmed_at).to_not be_nil
    end
  end

  context 'Failure' do
    let!(:user) { create(:user) }

    it 'fails to confirm' do
      expect(user.confirmed_at).to be_nil
      get user_confirmation_path, params: { confirmation_token: 'sd111' }
      expect(status).to eq(422)
      expect(json[:errors]).to include('Confirmation token is invalid')
      user.reload
      expect(user.confirmed_at).to be_nil
    end
  end
end
