class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true
  validates :password, length: { minimum: 7 }
  acts_as_followable # フォロワー機能
  acts_as_follower   # フォロー機能

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  has_many :groupmessages, dependent: :destroy

  has_many :friend_users, dependent: :destroy
  has_many :friends, through: :friend_users

  mount_uploader :image, ImageUploader
end
