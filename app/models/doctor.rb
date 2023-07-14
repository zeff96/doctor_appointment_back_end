class Doctor < ApplicationRecord
  has_one :social_medium
  has_one :location
  has_one :payment
  has_one_attached :image

  accepts_nested_attributes_for :social_medium
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :payment
end
