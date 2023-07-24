class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    if user_exists?(sign_up_params[:email])
      render json: { error: 'Email already exists. Please choose a different email!' }, status: :unprocessable_entity
    else
      build_resource(sign_up_params)
      if resource.save
        sign_in(resource_name, resource)
        render json: resource
      else
        render json: { error: 'Failed to create user. Check on input!' }, status: :unprocessable_entity
      end
    end
  end

  protected

  def user_exists?(email)
    User.exists?(email:)
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
