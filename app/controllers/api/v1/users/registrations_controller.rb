module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        before_action :configure_account_create_params, only: :create

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
      end
    end
  end
end
