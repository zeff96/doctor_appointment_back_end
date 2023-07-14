class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all

    render json: @doctors, each_serializer: DoctorSerializer
  end
end
