class LikeService
  def create(params, user)
    params[:user_id] = user.id
    Like.create!(params)
  end

  def destroy(id, params, current_user)
    like = Like.find_by!(likable_id: id, user_id: current_user.id, likable_type: params[:likable_type])
    Like.destroy!(like.id)
  end
end
