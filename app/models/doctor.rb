class Doctor < ApplicationRecord
  has_one :social_medium
  has_one :location
  has_one_attached :image

  accept_nested_attributes_for :social_media
end
