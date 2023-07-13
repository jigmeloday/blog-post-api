class Follow < ApplicationRecord
  belongs_to :followed_user, class_name: 'User', inverse_of: :followings, counter_cache: :follower_count
  belongs_to :user, counter_cache: :following_count

  validates :user_id, uniqueness: { scope: :followed_user_id, message: 'has already followed' }
end
