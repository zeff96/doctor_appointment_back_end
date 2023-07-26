class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  validates :date, presence: true
  validates :city, presence: true
  validates :user_name, presence: true

  before_validation :set_user_name

  private

  def set_user_name
    self.user_name = user&.name
  end
end
