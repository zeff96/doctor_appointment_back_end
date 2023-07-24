require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@test.com', password: 'password') }

  describe 'Validations' do
    subject { user }

    it 'validates the presence of name' do
      user.name = nil
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'validates the presence of email' do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates the presence of password' do
      user.password = nil
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end
  end
end
