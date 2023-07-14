class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show destroy]

  def index
    @doctors = Doctor.all

    render json: @doctors, each_serializer: DoctorSerializer
  end

  def show; end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      render :show, status: :created, location: @doctor
    else
      render json: {error: @doctor.errors.full_messages}, status: :unprocessable_entity
    end
  end
  
  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end