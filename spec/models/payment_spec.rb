require 'rails_helper'

RSpec.describe Payment, type: :model do
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

  describe 'validations' do
    before do
      @payment = doctor_with_image.build_payment(
        consultation_fee: 250
      )
    end

    it 'should be valid' do
      expect(@payment).to be_valid
    end
  end

  describe 'associations' do
    it 'should belong to doctor' do
      association = described_class.reflect_on_association(:doctor)
      expect(association.macro).to eq :belongs_to
    end
  end
end