require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:user) {User.create(name: 'test', email: 'test@test.com', password: 'password')}
  let(:image_path) {Rails.root.join('public', 'images', 'ani-kolleshi.jpg')}
  let(:image_file) {File.open(image_path)}
  let(:doctor_with_image) do
    doctor = Doctor.new(
      name: 'doc1',
      bio: 'doc from kenya',
      user: user
    )
    doctor.image.attach(io: image_file, filename: 'ani-kolleshi.jpg', content_type: 'image/jpeg')
    doctor
  end

  describe 'validations do' do
    before do
      @appointment = Appointment.create(
        date: Date.today,
        doctor: doctor_with_image,
        user: user
      )
    end

    it 'should be valid' do
      expect(@appointment).to be_valid
    end
  end
end