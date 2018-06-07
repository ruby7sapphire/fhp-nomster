class Place < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :photos

  geocoded_by :full_address
  after_validation :geocode

  validates :name, :address, :description, presence: true
  validates :name, length: { minimum: 4 }

  def full_address
    [name, address].join(' ')
  end
end
