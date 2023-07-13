class FollowService
  def create(params, user)
    params[:user_id] = user.id
    Follow.create!(params)
  end

  def destroy(id, user)
    follow = Follow.find_by!(followed_user_id: id, user_id: user.id)
    follow.destroy!
  end
end
