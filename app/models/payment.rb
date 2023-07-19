class Payment < ApplicationRecord
  belongs_to :doctor
  validates :consultation_fee, presence:true
end
