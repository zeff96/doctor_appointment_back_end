class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show destroy]

  def index
    @doctors = current_user.doctors

    render json: @doctors, each_serializer: DoctorSerializer
  end

  def show
    render json: @doctor
  end

  def new
    @doctor = Doctor.new
    @doctor.user = current_user
    @doctor.build_social_media
    @doctor.build_location
    @doctor.build_payment
  end

  def create
    @doctor = current_user.build_doctor(doctor_params)

    if @doctor.save
      render :show, status: :created, location: @doctor
    else
      render json: { error: @doctor.errors.full_messages }, status: :unprocessable_entity
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
    params.require(:doctor).permit(:name, :bio, :image,
                                   location_attributes: %i[address city state zip_code],
                                   social_media_attributes: %i[facebook twitter instagram],
                                   payment_attributes: :consultation_fee)
  end
end
