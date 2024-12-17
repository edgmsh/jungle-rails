require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context 'email and name validations' do
      it 'is valid with all required fields' do
        user = User.new(
          first_name: 'John',
          last_name: 'Doe',
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to be_valid
      end
  
      it 'is not valid without a first name' do
        user = User.new(
          first_name: nil,
          last_name: 'Doe',
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to_not be_valid
        expect(user.errors[:first_name]).to include("can't be blank")
      end
  
      it 'is not valid without a last name' do
        user = User.new(
          first_name: 'John',
          last_name: nil,
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to_not be_valid
        expect(user.errors[:last_name]).to include("can't be blank")
      end
  
      it 'is not valid without an email' do
        user = User.new(
          first_name: 'John',
          last_name: 'Doe',
          email: nil,
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end
  
      it 'is not valid with a duplicate email (case insensitive)' do
        User.create!(
          first_name: 'Jane',
          last_name: 'Doe',
          email: 'TEST@EXAMPLE.COM',
          password: 'password',
          password_confirmation: 'password'
        )
        user = User.new(
          first_name: 'John',
          last_name: 'Smith',
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include('has already been taken')
      end
  
      it 'is not valid with an improperly formatted email' do
        user = User.new(
          first_name: 'John',
          last_name: 'Doe',
          email: 'invalid_email',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include('is invalid')
      end
    end

    context 'password validations' do
      it 'is valid with matching password and password_confirmation' do
        user = User.new(
          first_name: 'John',
          last_name: 'Doe',
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        )
        expect(user).to be_valid
      end
  
      it 'is not valid without a password' do
        user = User.new(
          email: 'test@example.com',
          password: nil,
          password_confirmation: nil
        )
        expect(user).to_not be_valid
        expect(user.errors[:password]).to include("can't be blank")
      end
  
      it 'is not valid if password and password_confirmation do not match' do
        user = User.new(
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'different password'
        )
        expect(user).to_not be_valid
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
  
      it 'is not valid if the password is too short' do
        user = User.new(
          email: 'test@example.com',
          password: 'short',
          password_confirmation: 'short'
        )
        expect(user).to_not be_valid
        expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end
    end
  end

  describe '.authenticate_with_credentials' do
    let!(:user) { User.create(
      first_name: 'John',
      last_name: 'Doe',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    ) }

    context 'when email and password are correct' do
      it 'authenticates the user' do
        authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'when password is incorrect' do
      it 'does not authenticate the user' do
        authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
        expect(authenticated_user).to be_nil
      end
    end

    context 'when email is incorrect' do
      it 'does not authenticate the user' do
        authenticated_user = User.authenticate_with_credentials('nonexistent@example.com', 'password')
        expect(authenticated_user).to be_nil
      end
    end

    context 'when email has different casing' do
      it 'authenticates the user regardless of casing' do
        authenticated_user = User.authenticate_with_credentials('TEST@EXAMPLE.COM', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'when email has leading/trailing spaces' do
      it 'authenticates the user after stripping spaces' do
        authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'when email format is invalid' do
      it 'does not authenticate the user with an invalid email format' do
        invalid_user = User.authenticate_with_credentials('invalid-email', 'password')
        expect(invalid_user).to be_nil
      end
    end
  end
end