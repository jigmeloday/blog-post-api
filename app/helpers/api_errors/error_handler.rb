module ApiErrors
  module ErrorHandler
    def self.included(base)
      base.class_eval do
        rescue_from StandardError, with: :bad_request
        rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
        rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
        rescue_from Pundit::NotAuthorizedError, with: :not_authorized_error
        rescue_from ActiveModel::ValidationError, with: :validation_errors
        # rescue_from ActionController::ParameterMissing, with: :bad_request
        # rescue_from NoMethodError, with: :bad_request
        rescue_from ArgumentError, with: :bad_request
        rescue_from ActionController::MissingFile, with: :file_not_found
      end
    end

    def confirmation_error(error)
      render_error(:unprocessable_entity, error.full_messages)
    end

    def record_not_found(error)
      render_error(:not_found, [error.message])
    end

    def record_invalid(error)
      render_error(:unprocessable_entity, error.record.errors.full_messages)
    end

    def validation_errors(error)
      render_error(:unprocessable_entity, [error.message.sub(I18n.t('miscs.validation_failed'), '')])
    end

    def password_invalid(error)
      render_error(:unauthorized, [error.message])
    end

    def file_not_found(error)
      render_error(:not_found, [error.message])
    end

    def invalid_resource(record)
      render_error(:unprocessable_entity, record.errors.full_messages)
    end

    def bad_request(error)
      render_error(:bad_request, [error.message])
    end

    def not_authorized_error
      render_error(:forbidden, [I18n.t(:pundit)])
    end

    def render_error(status, errors)
      render json: { errors: errors }, status: status
    end
  end
end
