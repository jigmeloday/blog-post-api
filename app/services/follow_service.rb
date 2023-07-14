class FollowService < BaseService
  def create
    Follow.create!(params.merge!(user_id: current_user.id))
  end

  def destroy
    follow = Follow.find_by!(followed_user_id: params[:id], user_id: current_user.id)
    follow.destroy!
  end
end
