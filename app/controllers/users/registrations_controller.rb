class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      token = JsonWebToken.encode(user_id: resource.id)
      render json: { token: }
    else
      render json: { message: 'user not created!' }, status: :unprocessable_entity
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
