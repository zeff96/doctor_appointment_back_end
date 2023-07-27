class Users::PasswordsController < Devise::PasswordsController
  def create
    user = User.find_by(email: params[:user][:email])

    if user.present?
      user.send_reset_password_instructions
      render json: { message: 'Reset password instructions sent.' }, status: :ok
    else
      render json: { error: 'Email not found. Please check your email!' }, status: :unprocessable_entity
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(
      reset_password_token: params[:user][:reset_password_token],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )

    if resource.errors.empty?
      render json: { message: 'Password reset succesful' }, status: :ok
    else
      render json: { error: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end
end
