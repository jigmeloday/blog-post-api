class FollowService
  def create(params, user)
    params[:user_id] = user.id
    Follow.create!(params)
  end
end
