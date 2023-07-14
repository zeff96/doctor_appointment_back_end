class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show destroy]

  def index
    @doctors = Doctor.all

    render json: @doctors, each_serializer: DoctorSerializer
  end

  def show
    render json: @doctor
  end

  def new
    @doctor = Doctor.new
    @doctor.build_social_media
    @doctor.build_location
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      render :show, status: :created, location: @doctor
    else
      render json: {error: @doctor.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @doctor.destroy

    head :no_content
  end
  
  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:name, :bio, :image, location_attributes: [:address, :city, :state, :zip_code], social_media_attributes: [:facebook, :twitter, :instagram]) 
  end
end
