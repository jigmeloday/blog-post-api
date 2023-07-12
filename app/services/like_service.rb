class LikeService
  def create(params)
    Like.create!(params)
  end

  def destroy(id)
    Like.destroy(id)
  end
end
