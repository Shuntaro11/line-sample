class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true
  acts_as_followable # フォロワー機能
  acts_as_follower   # フォロー機能

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true,format: { with: VALID_EMAIL_REGEX}

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  has_many :groupmessages, dependent: :destroy

  has_many :friend_users, dependent: :destroy
  has_many :friends, through: :friend_users

  mount_uploader :image, ImageUploader
end
