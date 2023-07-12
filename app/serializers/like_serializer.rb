class LikeSerializer < ActiveModel::Serializer
  attributes(
    :user_id,
    :likable_id,
    :likable_type
  )
end
