class BaseService
  attr_accessor :params, :current_user, :id

  def initialize(current_user, params = {}, id = nil)
    @params = params
    @current_user = current_user
    @id = id
  end
end
