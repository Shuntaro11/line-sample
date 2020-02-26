class Friend < ApplicationRecord
  has_many :friend_users
  has_many :users, through: :friend_users

  has_many :directmessages, dependent: :destroy
end
