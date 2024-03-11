class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :user, :title, :body
end
