class SocialMedium < ApplicationRecord
  belongs_to :doctor
  validates :facebook, presence: true,
  validates :twitter, presence:true
  validates :instagram, presence:true
end
