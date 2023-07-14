class LikeService < BaseService
  def create
    Like.create!(params.merge!(user_id: current_user.id))
  end

  def destroy
    like = Like.find_by!(likable_id: id, user_id: current_user.id, likable_type: params[:likable_type])
    like.destroy!
  end
end
