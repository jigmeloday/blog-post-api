class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  belongs_to :user

  # validates_presence_of :likeable, :user
end
