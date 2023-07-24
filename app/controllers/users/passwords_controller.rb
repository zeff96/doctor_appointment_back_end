# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    super
  end

  # POST /resource/password
  def create
    user = User.find_by(email: params[:user][:email])

    if user.present?
      user.send_reset_password_instructions
      render json: {message: 'Reset password instructions sent.'}, status: :ok
    else
      render json: {error: 'Email not found. Please check your email!'}, status: :unprocessable_entity
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(
      reset_password_token: params[:user][:reset_password_token],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )

    if resource.errors.empty?
      render json: {message: 'Password reset succesful'}, status: :ok
    else
      render json: {error: resource.errors.full_messages.join(', ')}, status: :unprocessable_entity
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
