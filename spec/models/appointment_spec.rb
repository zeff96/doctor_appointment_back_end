require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }
  let(:doctor_with_image) do
    doctor = Doctor.new(
      name: 'doc1',
      bio: 'doc from kenya',
      image: 'www.image.com',
      user:
    )
    doctor
  end

  describe 'validations do' do
    before do
      @appointment = Appointment.create(
        date: Date.today,
        city: 'Migori',
        doctor: doctor_with_image,
        user:
      )
    end

    it 'should be valid' do
      expect(@appointment).to be_valid
    end
  end

  describe 'associatios' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to doctor' do
      association = described_class.reflect_on_association(:doctor)
      expect(association.macro).to eq :belongs_to
    end
  end
end
