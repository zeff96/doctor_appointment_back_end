class AppointmentsController < ApplicationController
  before_action :set_doctor, only: %i[new create index]

  def index
    @appointments = current_user.appointments.includes(:doctor)
    render json: @appointments, each_serializer: AppointmentSerializer
  end

  def new
    @appointment = @doctor.appointments.build(user_name: current_user&.name)
  end

  def create
    @appointment = current_user.@doctor.appointments.build(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: { error: @appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    head :no_content
  end

  private

  def set_doctor
    @doctor = params[:doctor_id] ? Doctor.find(params[:doctor_id]) : nil
  end

  def appointment_params
    params.require(:appointment).permit(:date, :city, :user_id, :user_name)
  end
end
