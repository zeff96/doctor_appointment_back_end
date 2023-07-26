require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe AppointmentsController, type: :request do
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

  let(:appointment_params) do
    {
      date: Date.today,
      user_id: user.id
    }
  end

  describe 'GET /doctors/:id/appointments' do
    before do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      @doctor = user.doctors.create(doctor_params)
      @appointment = @doctor.appointments.create(appointment_params)
      get "/doctors/#{@doctor.id}/appointments", headers: auth_headers
    end

    it 'return list of all appointments' do
      expect(response).to have_http_status(:success)
    end

    it 'respond with a json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
      json_respone = JSON.parse(response.body)
      expect(json_respone).to be_an(Array)
    end
  end

  describe 'POST /doctors/:id/appointments' do
    before do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      allow_any_instance_of(AppointmentsController).to receive(:current_user).and_return(user)
      @doctor = user.doctors.create(doctor_params)
    end
    it 'creates a new appointment' do
      post "/doctors/#{@doctor.id}/appointments", params: { appointment: appointment_params }.to_json,
                                                  headers: @auth_headers
      expect(response).to have_http_status(:created)
      expect(@doctor.appointments.count).to eq(1)
    end

    it 'respond with a json' do
      post "/doctors/#{@doctor.id}/appointments", params: { appointment: appointment_params }.to_json,
                                                  headers: @auth_headers
      expect(response.content_type).to eq('application/json; charset=utf-8')
      json_respone = JSON.parse(response.body)
      expect(json_respone).to be_an(Hash)
    end

    it 'returns validation errors' do
      invalid_params = { date: '' }
      post "/doctors/#{@doctor.id}/appointments", params: { appointment: invalid_params }.to_json,
                                                  headers: @auth_headers
      expect(response).to have_http_status(:unprocessable_entity)
      json_respone = JSON.parse(response.body)
      expect(json_respone).to have_key('error')
    end
  end

  describe 'DELETE /doctors/:id/appointments' do
    before do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      @doctor = user.doctors.create(doctor_params)
      @appointment = @doctor.appointments.create!(appointment_params)
    end
    it 'deletes an appointment' do
      expect do
        delete "/doctors/#{@doctor.id}/appointments/#{@appointment.id}", headers: @auth_headers
      end.to change(Appointment, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
