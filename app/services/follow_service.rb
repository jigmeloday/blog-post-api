class FollowService < BaseService
  def create
    params[:user_id] = current_user.id
    Follow.create!(params)
  end

  def destroy
    follow = Follow.find_by!(followed_user_id: params[:id], user_id: current_user.id)
    follow.destroy!
  end
end
