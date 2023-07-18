# frozen_string_literal: true

module Api
  module V1
    module Users
      class ConfirmationsController < Devise::ConfirmationsController
        def respond_with(resource, _opts = {})
          if resource.errors.present?
            confirmation_error(resource)
          else
            render json: resource, serializer: UserSerializer
          end
        end
      end
    end
  end
end
