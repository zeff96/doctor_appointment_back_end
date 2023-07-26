class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :city, :user_name, :doctor_name

  def doctor_name
    object.doctor.name
  end
end
