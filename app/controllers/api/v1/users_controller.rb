module Api
  module V1
    class UsersController < ApplicationController
      include HelperMethods

      skip_before_action :authenticate_user!

      def resend_code_email
        user_by_email.update!(confirmation_token: token, confirmation_sent_at: Time.zone.now) &&
          user_by_email.send_confirmation_instructions
        render json: { message: 'Verification code sent.' }
      end

      private

      def user_by_email
        User.find_by(email: params[:email])
      end
    end
  end
end
