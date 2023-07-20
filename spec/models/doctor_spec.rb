require 'rails_helper'

RSpec.describe 'Doctor', type: :model do
  let(:user) {User.create(name: 'test', email: 'test@test.com', password: 'password')}

  describe 'Validations' do
    subject(:doctor) do
      image_path = Rails.root.join('public', 'images', 'ani-kolleshi.jpg')
      image_file = File.open(image_path)
      doctor = Doctor.new(
        name: 'doc1',
        bio: 'doc from kenya',
        user: user
      )
      doctor.image.attach(io: image_file, filename: 'ani-kolleshi.jpg', content_type: 'image/jpeg')
      doctor
    end

    context 'Return valid data' do
      it 'should accept name' do
        subject.name = 'post'
        expect(subject).to be_valid
      end

      it 'should accept bio' do
        subject.bio = 'Experienced Psychiatry doctor with abundance of experience'
        expect(subject).to be_valid
      end
    end

    context 'Return invalid data' do
      it 'should return invalid without name' do
        subject.name = nil
        expect(subject).to_not be_valid
      end
    end
  end
end