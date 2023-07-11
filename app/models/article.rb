class Article < ApplicationRecord
  belongs_to :user

  validates_presence_of :user, :title, :body
end