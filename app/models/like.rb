class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true, counter_cache: :like_count
  belongs_to :user

  validates :user_id, uniqueness: { scope: :likable_id, message: 'has already liked it!' }
end
