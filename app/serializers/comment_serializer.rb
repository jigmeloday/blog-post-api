class CommentSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :user_id,
    :commentable_id,
    :commentable_type,
    :body,
    :created_at,
    :updated_at
  )
end
