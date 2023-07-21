class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  before_action :configure_sign_up_params, only: [:create]

  def create
    build_resource(sign_up_params)

    if resource.save
      token = JsonWebToken.encode(user_id: resource.id)
      render json: { token: token }
    else
      render json: { message: 'user not created!' }, status: :unprocessable_entity
    end
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end

