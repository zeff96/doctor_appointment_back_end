class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :city

  def city
    object.doctor.location.city
  end
end
