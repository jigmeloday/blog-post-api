class LikeService
  def create(params)
    binding.pry
    Like.create!(params)
  end
end
