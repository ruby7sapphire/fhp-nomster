class Place < ApplicationRecord
  belongs_to :user

  def full_address
    [self.name, self.address].join(' ')
	end

  geocoded_by :full_address
  after_validation :geocode

  validates :name, :address, :description, presence: true
  validates :name, length: { minimum: 4 }
end
