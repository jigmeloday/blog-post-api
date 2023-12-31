# frozen_string_literal: true

module Api
  module V1
    module Users
      class ConfirmationsController < Devise::ConfirmationsController
        def create
          self.resource = resource_class.send_confirmation_instructions(resource_params)

          if successfully_sent?(resource)
            respond_with(resource)
          else
            not_authorized_error
          end
        end

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
