require 'rails_helper'

describe 'Sign Out' do
  context 'Success' do
    let!(:user) { create(:user, :confirmed) }

    it 'signs out' do
      sign_in_with_pwd(user, user.password)
      expect(cookies[:_backend_key]).to_not be_nil
      delete destroy_user_session_path
      expect(status).to eq(200)
      expect(response.cookies[:_backend_key]).to be_nil
    end
  end
end
