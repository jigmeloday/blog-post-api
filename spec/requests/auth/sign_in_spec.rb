require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Sign In' do
  let!(:email) { 'dg@gmail.com' }
  let!(:pwd) { 'password' }

  context 'Success' do
    let!(:user) { create(:user, :confirmed, email: email, password: pwd) }
    let!(:params) do
      {
        user: {
          email: email,
          password: pwd
        }
      }
    end

    it 'signs in' do
      expect(cookies[:_backend_key]).to be_nil
      post user_session_path, params: params
      expect(status).to eq(200)
      expect(cookies[:_backend_key]).to_not be_nil
    end
  end

  context 'Failure' do
    let!(:user) { create(:user, :confirmed, email: email, password: pwd) }
    let!(:params) do
      {
        user: {
          email: email,
          password: 'sdf'
        }
      }
    end

    it 'doesn\'t sign in' do
      expect(cookies[:_backend_key]).to be_nil
      post user_session_path, params: params
      expect(status).to eq(401)
      expect(json[:error]).to eq('Invalid Email or password.')
      expect(cookies[:_backend_key]).to be_nil
    end
  end

  context 'Failure' do
    let!(:user) { create(:user, :confirmed, email: email, password: pwd) }
    let!(:params) do
      {}
    end

    it 'doesn\'t sign in' do
      expect(cookies[:_backend_key]).to be_nil
      post user_session_path, params: params
      expect(status).to eq(401)
      expect(json[:error]).to eq('You need to sign in or sign up before continuing.')
      expect(cookies[:_backend_key]).to be_nil
    end
  end
end
# rubocop:enable Metrics/BlockLength
