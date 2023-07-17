class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, counter_cache: :comment_count
  belongs_to :user
  has_many :likes

  validates_presence_of :body
end
