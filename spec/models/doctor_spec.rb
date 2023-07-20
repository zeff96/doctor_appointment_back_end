require 'rails_helper'

RSpec.describe Doctor, type: :model do
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

      it 'should return invalid without bio' do
        subject.bio = nil
        expect(subject).to_not be_valid
      end
    end
  end
  
  describe 'Associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)      
      expect(association.macro).to eq :belongs_to
    end

    it 'has many appoitments' do
      association = described_class.reflect_on_association(:appointments)
      expect(association.macro).to eq :has_many
    end

    it 'has one social media' do
      association = described_class.reflect_on_association(:social_medium)
      expect(association.macro).to eq :has_one
    end

    it 'has one location' do
      association = described_class.reflect_on_association(:location)
      expect(association.macro).to eq :has_one
    end

    it 'has one payment' do
      association = described_class.reflect_on_association(:payment)
      expect(association.macro).to eq :has_one
    end
  end

  describe 'Nested attributes' do
    it 'accepts nested attributes for social media' do
      association = described_class.reflect_on_association(:social_medium)
      expect(association.options[:autosave]).to be(true)
    end
  end
end
