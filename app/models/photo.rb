class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :place
  mount_uploader :picture, PictureUploader

  validates :picture, presence: true

  default_scope { order(created_at: :asc) }
end
