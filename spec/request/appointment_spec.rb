require 'rails_helper'
require 'jwt'

RSpec.describe AppointmentsController, type: :request do
  let(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }
  let(:file_path) { Rails.root.join('public', 'images', 'ani-kolleshi.jpg') }

  let(:token) do
    payload = { user_id: user.id }
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

  let(:appointment_params) do
    {
      date: Date.today,
      user:
    }
  end

  describe 'GET /doctors/:id/appointments' do
    before do
      headers = { 'Authorization' => "Bearer #{token}" }
      @doctor = user.doctors.create(doctor_params)
      @appointment = @doctor.appointments.create(appointment_params)
      get "/doctors/#{@doctor.id}/appointments", headers:
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
      headers = { 'Authorization' => "Bearer #{token}" }
      allow_any_instance_of(AppointmentsController).to receive(:current_user).and_return(user)
      @doctor = user.doctors.create(doctor_params)
      post "/doctors/#{@doctor.id}/appointments", params: { appointment: appointment_params }, headers:
    end
    it 'creates a new appointment' do
      expect(response).to have_http_status(:created)
      expect(@doctor.appointments.count).to eq(1)
    end

    it 'respond with a json' do
      expect(response.content_type).to eq("application/json; charset=utf-8")
      json_respone = JSON.parse(response.body)
      expect(json_respone).to be_an(Hash)
    end
  end

  describe 'DELETE /doctors/:id/appointments' do
    before do
      @doctor = user.doctors.create(doctor_params)
      @appointment = @doctor.appointments.create!(appointment_params)
    end
    it 'deletes an appointment' do
      expect do
        delete "/doctors/#{@doctor.id}/appointments/#{@appointment.id}", headers:
      end.to change(Appointment, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
