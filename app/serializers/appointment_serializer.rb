class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :city, :user_name
  belongs_to :doctor, key: :doctor_name, serializer: DoctorNameSerializer
end
