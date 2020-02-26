class FriendUser < ApplicationRecord
  belongs_to :user
  belongs_to :friend
end
