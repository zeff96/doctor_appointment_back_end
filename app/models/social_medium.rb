class SocialMedium < ApplicationRecord
  belongs_to :doctor

  validates :facebook, presence: true
  validates :instagram, presence: true
  validates :twitter, presence: true
  validates :linkedin, presence: true
  validates :youtube, presence: true
end
