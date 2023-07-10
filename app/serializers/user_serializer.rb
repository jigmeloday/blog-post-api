class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :email,
    :following_count,
    :follower_count,
    :article_count,
    :gender,
    :username
  )
end
