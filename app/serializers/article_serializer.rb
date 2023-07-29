class ArticleSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :body,
    :like_count,
    :comment_count,
    :user_id,
    :liked_by_current_user,
    :owner,
    :created_at
  )

  def liked_by_current_user
    return false unless current_user

    object.likes.find_by(user_id: current_user.id).present?
  end

  def owner
    object.user
  end
end
