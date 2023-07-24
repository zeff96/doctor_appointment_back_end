class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate(auth_options)
    if resource.present?
      sign_in(resource_name, resource)
      user_serializer = UserSerializer.new(resource)
      render json: {
        user: user_serializer.to_json
      }, status: :ok
    else
      render json: {
        error: 'Incorrect email or password. Please try again!'
      }, status: :unauthorized
    end
  end

  private

  def respond_to_on_destroy
    render json: { message: 'Logged out.' }
  end
end
