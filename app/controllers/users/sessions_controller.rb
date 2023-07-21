class Users::SessionsController < Devise::SessionsController
  respond_to :json
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate(auth_options)
    if resource.present?
      sign_in(resource_name, resource)
      user_serializer = UserSerializer.new(resource)
      render json: {
        status: {
          code: 200,
          message: 'Signed in successfully'
        },
        data: user_serializer.to_json,
        token: JsonWebToken.encode(user_id: resource.id)
      }, status: :ok
    else
      render json: {
        status: {
          code: 401,
          message: 'Invalid credentials'
        }
      }, status: :unauthorized
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
