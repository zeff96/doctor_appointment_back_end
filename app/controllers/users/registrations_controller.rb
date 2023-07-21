class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def respond_with(resource, _opts = {})
    if user.persisted?

      render json: {
        status: {
          code: 200,
          message: 'Signed up successfully.'
        },
        token: JsonWebToken.encode(user_id: user.id)
      }, status: :ok
    end
  end
end
