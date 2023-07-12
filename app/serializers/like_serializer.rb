class LikeSerializer < ActiveModel::Serializer
  attribute(
    :user_id,
    :likable_id
  )
end
