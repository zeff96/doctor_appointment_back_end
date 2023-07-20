class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  validates :date, presence: true

  def city
    doctor.location.city
  end
end
