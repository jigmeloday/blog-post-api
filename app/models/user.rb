class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles
  has_many :followings, foreign_key: :followed_user_id, class_name: 'Follow', inverse_of: :followed_user,
                        dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum gender: { male: 0, female: 1, other: 2 }
end
