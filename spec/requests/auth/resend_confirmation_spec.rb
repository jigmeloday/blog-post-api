require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Resend Confirmation Code' do
  context 'Success' do
    let!(:user) { create(:user) }
    let!(:params) do
      {
        user: {
          email: user.email
        }
      }
    end

    it 'confirms' do
      expect(user.confirmed_at).to be_nil
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      post user_confirmation_path, params: params
      expect(status).to eq(200)
      expect(ActionMailer::Base.deliveries.count).to eq(2)
      expect(user.confirmed_at).to be_nil
    end
  end

  context 'Failure' do
    let!(:user) { create(:user) }
    let!(:params) do
      {
        user: {
          email: 'dg@gmail.com'
        }
      }
    end

    it 'fails to send reconfirmation email' do
      expect(user.confirmed_at).to be_nil
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      post user_confirmation_path, params: params
      expect(status).to eq(403)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
      user.reload
      expect(user.confirmed_at).to be_nil
    end
  end

  context 'Failure' do
    let!(:user) { create(:user, :confirmed) }
    let!(:params) do
      {
        user: {
          email: user.email
        }
      }
    end

    it 'fails to send reconfirmation email for confirmed user' do
      expect(ActionMailer::Base.deliveries.count).to eq(0)
      post user_confirmation_path, params: params
      expect(status).to eq(403)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end
end
# rubocop:enable Metrics/BlockLength
