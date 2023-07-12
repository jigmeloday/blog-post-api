class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true, counter_cache: :like_count
  belongs_to :user

  # validates_presence_of :likeable, :user
end
