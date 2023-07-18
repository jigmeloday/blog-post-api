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
    comment.destroy!
  end

  private

  def comment
    @comment ||= Comment.find(id)
  end
end
