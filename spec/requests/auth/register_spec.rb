require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Registration' do
  context 'Success' do
    let!(:params) do
      {
        user: {
          email: 'dg@gmail.com',
          password: 'password',
          password_confirmation: 'password',
          username: 'baka',
          name: 'Dorji',
          gender: 'male'
        }
      }
    end

    it 'registers' do
      expect(ActionMailer::Base.deliveries.count).to eq(0) # This Expects the mailer to have 0 delivery in queue
      expect(User.count).to eq(0)
      post user_registration_path, params: params
      expect(status).to eq(200)
      expect(User.count).to eq(1)
      expect(ActionMailer::Base.deliveries.count).to eq(1) # This Expects the mailer to have 1 delivery in queue
    end
  end

  context 'Email is taken' do
    let!(:user) { create(:user, email: 'dg@gmail.com') }
    let!(:params) do
      {
        user: {
          email: 'dg@gmail.com',
          password: 'password',
          password_confirmation: 'password',
          username: 'baka',
          name: 'Dorji',
          gender: 'male'
        }
      }
    end

    it 'fails to registers' do
      expect(ActionMailer::Base.deliveries.count).to eq(1) # This Expects the mailer to have 0 delivery in queue
      expect(User.count).to eq(1)
      post user_registration_path, params: params
      expect(status).to eq(422)
      expect(json[:errors]).to include('Email has already been taken')
      expect(User.count).to eq(1)
      expect(ActionMailer::Base.deliveries.count).to eq(1) # This Expects the mailer to have 1 delivery in queue
    end
  end

  context 'Username is taken' do
    let!(:user) { create(:user, username: 'baka') }
    let!(:params) do
      {
        user: {
          email: 'dg@gmail.com',
          password: 'password',
          password_confirmation: 'password',
          username: 'baka',
          name: 'Dorji',
          gender: 'male'
        }
      }
    end

    it 'fails to registers' do
      expect(ActionMailer::Base.deliveries.count).to eq(1) # This Expects the mailer to have 0 delivery in queue
      expect(User.count).to eq(1)
      post user_registration_path, params: params
      expect(status).to eq(422)
      expect(json[:errors]).to include('Username has already been taken')
      expect(User.count).to eq(1)
      expect(ActionMailer::Base.deliveries.count).to eq(1) # This Expects the mailer to have 1 delivery in queue
    end
  end
end
# rubocop:enable Metrics/BlockLength
