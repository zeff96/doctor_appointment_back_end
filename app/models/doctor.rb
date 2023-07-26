class Doctor < ApplicationRecord
  belongs_to :user
  has_many :appointments
  has_one :social_medium, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :payment, dependent: :destroy

  accepts_nested_attributes_for :social_medium
  accepts_nested_attributes_for :location
  accepts_nested_attributes_for :payment

  validates :name, presence: true
  validates :bio, presence: true
  validates :image, presence: true
end
