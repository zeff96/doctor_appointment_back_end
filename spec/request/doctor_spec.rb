require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe DoctorsController, type: :request do
  let(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }

  let(:doctor_params) do
    {
      name: 'doc2',
      bio: 'doc from kenya',
      image: 'www.image.com',
      location_attributes: { address: '123 Main St', city: 'New York', state: 'NY', zip_code: '10001' },
      social_medium_attributes: { facebook: 'facebook_url', twitter: 'twitter_handle', instagram: 'instagram_handle' },
      payment_attributes: { consultation_fee: 100 }
    }
  end

  describe 'GET /doctors' do
    before do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      user.doctors.create(doctor_params)

      get '/doctors', headers: auth_headers
    end

    it 'return list of all doctors' do
      expect(response).to have_http_status(:success)
    end

    it 'responds with a json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
      json_respone = JSON.parse(response.body)
      expect(json_respone).to be_an(Array)
    end
  end

  describe 'GET /doctors/:id' do
    before do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      doctor = user.doctors.create(doctor_params)

      get "/doctors/#{doctor.id}", headers: auth_headers
    end

    it 'return doctor details' do
      expect(response).to have_http_status(:success)
    end

    it 'responds with a json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
      json_respone = JSON.parse(response.body)
      expect(json_respone).to be_an(Hash)
    end
  end

  describe 'POST /doctors' do
    before do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      allow_any_instance_of(DoctorsController).to receive(:current_user).and_return(user)
    end

    it 'creates a new doctor' do
      post '/doctors', params: { doctor: doctor_params }.to_json, headers: @auth_headers
      expect(response).to have_http_status(:created)
    end

    it 'responds with a json' do
      post '/doctors', params: { doctor: doctor_params }.to_json, headers: @auth_headers
      expect(response.content_type).to eq('application/json; charset=utf-8')
      json_respone = JSON.parse(response.body)
      expect(json_respone).to be_an(Hash)
    end

    it 'returns validation errors' do
      invalid_params = { name: '', bio: 'invalid doctor' }
      post '/doctors', params: { doctor: invalid_params }.to_json, headers: @auth_headers

      expect(response).to have_http_status(:unprocessable_entity)
      response_body = JSON.parse(response.body)
      expect(response_body).to have_key('error')
    end
  end

  describe 'DELETE /doctors/:id' do
    it 'deletes a doctor' do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      doctor = user.doctors.create(doctor_params)
      expect do
        delete "/doctors/#{doctor.id}", headers: auth_headers
      end.to change(Doctor, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
