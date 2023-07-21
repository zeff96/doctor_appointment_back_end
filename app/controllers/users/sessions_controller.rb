class Users::SessionsController < Devise::SessionsController
  respond_to :json

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

  def destroy
    super do |_user|
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
end
