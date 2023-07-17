class Doctor < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_one :social_medium, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :payment, dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :social_medium
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :payment
end
