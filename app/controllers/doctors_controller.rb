class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show destroy]
  
  def index
    @doctors = Doctor.all

    render json: @doctors, each_serializer: DoctorSerializer
  end

  
  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
