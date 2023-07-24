module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        include HelperMethods
        before_action :configure_account_create_params, only: :create
        def create
          User.create!(configure_sign_up_params.merge(confirmation_token: token, confirmation_sent_at: Time.zone.now))
          render json: { message: 'Verification code sent to the email' }
        end

        protected

        def configure_account_create_params
          # params[:user][:role_id] = 5
          devise_parameter_sanitizer.permit(:sign_up, keys: register_user_attributes)
        end

        def respond_with(resource, _opts = {})
          if resource.errors.present?
            invalid_resource(resource)
          else
            render json: resource, serializer: UserSerializer
          end
        end

        def configure_sign_up_params
          params.require(:user).permit(
            :username,
            :name,
            :email,
            :password,
            :password_confirmation,
            :gender
          )
        end
      end
    end
  end
end
