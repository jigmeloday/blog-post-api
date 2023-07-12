class ArticleSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :body,
    :like_count,
    :comment_count,
    :user_id
  )

  # def liked_by_current_user
  #   object.likes.find_by(user_id: current_user.id).present?
  # end
end
