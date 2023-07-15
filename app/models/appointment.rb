class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  def city
    doctor.location.city
  end
end
