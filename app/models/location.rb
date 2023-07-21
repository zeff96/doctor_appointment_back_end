class Location < ApplicationRecord
  belongs_to :doctor

  validates :address, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :state, presence: true
end
