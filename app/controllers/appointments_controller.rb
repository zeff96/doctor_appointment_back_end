class AppointmentsController < ApplicationController
  before_action :set_doctor, only: %i[new create index]

  def index
    @appointments = @doctor.appointments
    render json: @appointments, each_serializer: AppointmentSerializer
  end

  def new
    @appointment = @doctor.appointments.build
  end

  def create
    @appointment = @doctor.appointments.build(appointment_params)
    @appointment.user = current_user

    if @appointment.save
      render json: @appointment
    else
      render json: { error: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    head :no_content
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def appointment_params
    params.require(:appointment).permit(:date)
  end
end
