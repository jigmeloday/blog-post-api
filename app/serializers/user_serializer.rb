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
    :profile_url,
    :following
  )

  def following
    current_user ? current_user.follows.find_by(followed_user_id: object.id).present? : false
  end

  def profile_url
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
  end
end
