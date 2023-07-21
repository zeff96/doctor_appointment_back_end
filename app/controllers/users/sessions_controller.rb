class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do |user|
      user_serializer = UserSerializer.new(resource)
      if user.persisted?
        render json: {
          status: {
            code: 200,
            message: 'Signed in successfully'
          },
          data: user_serializer.to_json,
          token: JsonWebToken.encode(user_id: user.id)
        }, status: :ok
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    super do |user|
      if current_user
        render json: {
                status: {
                  code: 200,
                  message: 'Signed out successfully'
                }
              },
              status: :ok
      else
        render json: {
          status: {
            code: 401,
            message: 'Not signed in'
          }
        }, status: :unauthorized
      end
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
