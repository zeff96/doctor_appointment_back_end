require 'rails_helper'

RSpec.describe DoctorsController, type: :request do

  let(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }
  let(:file_path) {Rails.root.join('public', 'images', 'ani-kolleshi.jpg') }

  let(:token) do
    payload = {user_id: user.id}
    secret_key = Rails.application.secrets.secret_key
    JWT.encode(payload, secret_key)
  end

  let(:doctor_params) do
    {
      name: 'doc2',
      bio: 'doc from kenya',
      image: Rack::Test::UploadedFile.new(file_path, 'image/jpeg'),
      location_attributes: { address: '123 Main St', city: 'New York', state: 'NY', zip_code: '10001' },
      social_medium_attributes: { facebook: 'facebook_url', twitter: 'twitter_handle', instagram: 'instagram_handle' },
      payment_attributes: { consultation_fee: 100 }
    }
  end

  before do
    headers = { 'Authorization' => "Bearer #{token}" }
    user.doctors.create(doctor_params)

    get '/doctors', headers: headers
  end

  describe 'GET /doctors' do
    it 'return list of all doctors' do
      expect(response).to have_http_status(:success)
    end
  end
end