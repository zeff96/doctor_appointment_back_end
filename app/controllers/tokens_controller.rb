class TokensController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = generate_token(user)
      render json: { token: }, status: :created
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def verify
    token = params[:token]
    decoded_token = decode_token(token)

    if decoded_token
      user = User.find_by(id: decoded_token['userId'])

      if user
        render json: { user: }, status: :ok
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

  private

  def generate_token(user)
    payload = { user_id: user.id }
    secret_key = Rails.application.secrets.secret_key_base
    JWT.encode(payload, secret_key)
  end

  def decode_token(token)
    secret_key = Rails.application.secrets.secret_key_base
    decoded_token = JWT.decode(token, secret_key)[0]
    HashWithIndifferentAccess.new decoded_token
  rescue JWT::DecodeError
    nil
  end
end
