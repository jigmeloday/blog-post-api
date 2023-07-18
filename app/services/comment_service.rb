class CommentService < BaseService
  def create
    Comment.create!(params.merge!(user_id: current_user.id))
  end

  def update
    authorize comment, :update?
    comment.update!(params)
    comment
  end

  def destroy
    authorize comment, :destroy?
    Comment.destroy(id)
  end

  private

  def comment
    Comment.find(id)
  end
end
