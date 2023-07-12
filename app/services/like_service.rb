class LikeService
  def create(params, user)
    params[:user_id] = user.id
    Like.create!(params)
  end

  def destroy(id)
    Like.destroy(id)
  end
end
