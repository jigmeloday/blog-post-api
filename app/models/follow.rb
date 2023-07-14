class Follow < ApplicationRecord
  belongs_to :followed_user, class_name: 'User', inverse_of: :followings, counter_cache: :follower_count
  belongs_to :user, counter_cache: :following_count

  validate :cannot_follow_self
  validates :user_id, uniqueness: { scope: :followed_user_id, message: 'has already followed' }

  private

  def cannot_follow_self
    errors.add(:user_id, 'cannot follow themselves') if user_id == followed_user_id
  end
end
