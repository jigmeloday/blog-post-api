module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        def create
          super.tap do
            old_values = session.to_hash
            reset_session
            session.update old_values.except('_backend_key')
            # render json: { signedIn: true }
          end
        end

        def respond_with(resource, _opts = {})
          if resource.errors.present?
            invalid_resource(resource)
          else
            render json: { success: true }
          end
        end

        def respond_to_on_destroy
          head :ok
        end
      end
    end
  end
end