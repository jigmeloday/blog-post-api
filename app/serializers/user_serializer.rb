class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :name,
    :email,
    :following_count,
    :follower_count,
    :article_count,
    :gender,
    :username,
    :following
  )

  def following
    current_user ? current_user.follows.find_by(followed_user_id: object.id).present? : false
  end
end
