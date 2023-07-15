class AppointmentsController < ApplicationController
  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def appointment_params
    params.require(:appointment).permit(:date.merge(user_id: current_user.id))
  end
end
