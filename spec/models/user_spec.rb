require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "creates new User with valid attributes" do
      User.create!({
        first_name: 'Bruce',
        last_name: 'Wayne',
        email: 'notbatman@batman.com',
        password: '12345678',
        password_confirmation: '12345678'
        }).should be_valid
    end
    it "fails to create new User without a password" do
      User.create({
        first_name: 'Bruce',
        last_name: 'Wayne',
        email: 'notbatman@batman.com',
        password_confirmation: '12345678'
        }).should_not be_valid
    end
    it "fails to create new User when password and confirmation don't match" do
      User.create({
        first_name: 'Bruce',
        last_name: 'Wayne',
        email: 'notbatman@batman.com',
        password: '87654321',
        password_confirmation: '12345678'
        }).should_not be_valid
    end
    it "fails to create new User without password confirmation" do
      User.create({
        first_name: 'Bruce',
        last_name: 'Wayne',
        email: 'notbatman@batman.com',
        password: '12345678'
        }).should_not be_valid
    end
    it "fails to create new User when password is not long enough" do
      User.create({
        first_name: 'Bruce',
        last_name: 'Wayne',
        email: 'notbatman@batman.com',
        password: '12345',
        password_confirmation: '12345'
        }).should_not be_valid
    end
    it "fails to create new User when email is already in use (NOT case-sensitive)" do
      User.create!({
        first_name: 'Bruce',
        last_name: 'Wayne',
        email: 'notbatman@batman.com',
        password: '12345678',
        password_confirmation: '12345678'
      })
      User.create({
        first_name: 'Bruce',
        last_name: 'Wayne',
        email: 'NotBatman@batman.com',
        password: '12345678',
        password_confirmation: '12345678'
      }).should_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create!({
        first_name: 'Hal ',
        last_name: 'Jordan',
        email: 'green@lantern.com',
        password: '12345678',
        password_confirmation: '12345678'
      })
    end

    it "authenticates registered user with email and password" do
      expect(User.authenticate_with_credentials('green@lantern.com', '12345678')).to eq(@user)
    end

    it "authenticates registered user even with spaces before the email" do
      expect(User.authenticate_with_credentials('  green@lantern.com', '12345678')).to eq(@user)
    end

    it "authenticates registered user even with uppercase letters in email" do
      expect(User.authenticate_with_credentials('Green@Lantern.com', '12345678')).to eq(@user)
    end

    it "fails authentication with wrong password" do
      User.authenticate_with_credentials('green@lantern.com', '12345999').should be false
    end

    it "fails authentication with non-existent user info" do
      User.authenticate_with_credentials('barry@allen.com', '12345999').should be false
    end
  end
end
