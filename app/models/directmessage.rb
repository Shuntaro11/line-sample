class Directmessage < ApplicationRecord
  belongs_to :friend
  belongs_to :user

  validates :content, presence: true, unless: :image?

  mount_uploader :image, ImageUploader
end
