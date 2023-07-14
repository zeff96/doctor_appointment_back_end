class Location < ApplicationRecord
  has_many :doctors
  has_many :appointments
  has_many :patients, through: :appointments
  belongs_to :doctor
end
