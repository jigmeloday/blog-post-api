class ApplicationController < ActionController::API
  include ApiErrors::ErrorHandler
  include ParamsSanitizer
  include Pundit::Authorization

  before_action :authenticate_user!
end
