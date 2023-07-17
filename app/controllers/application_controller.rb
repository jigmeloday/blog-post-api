class ApplicationController < ActionController::API
  include ApiErrors::ErrorHandler
  include ParamsSanitizer

  before_action :authenticate_user!
end
