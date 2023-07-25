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
    @doctor.user = current_user
    @doctor.build_social_medium
    @doctor.build_location
    @doctor.build_payment
  end

  def create
    @doctor = current_user.doctors.build(doctor_params)

    @doctor.image.attach(params[:doctor][:image]) if params[:doctor][:image]

    if @doctor.save
      render json: @doctor, status: :created
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
                                   social_medium_attributes: %i[facebook twitter instagram],
                                   payment_attributes: :consultation_fee)
  end
end
