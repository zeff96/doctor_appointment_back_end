class Doctor < ApplicationRecord
  has_one :social_medium
  has_one :location
  has_one :payment
  has_one_attached :image

  has_many :appointments
end
