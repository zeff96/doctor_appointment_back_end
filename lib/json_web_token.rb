class JsonWebToken
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key)
    end

    def decode(token)
      JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key)[0]
    rescue JWT::DecodeError
      nil
    end
  end
end
