class BaseService
  # include Pundit::Authorization
  attr_accessor :params, :current_user, :record

  def initialize(current_user, params = {}, record = {})
    @params = params
    @current_user = current_user
    @record = record
  end
end
