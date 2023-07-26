class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :date, :city, :user_name
end
