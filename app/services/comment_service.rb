class CommentService < BaseService
  def create
    Comment.create!(params.merge!(user_id: current_user.id))
  end

  def destroy
    Comment.destroy(id)
  end
end
