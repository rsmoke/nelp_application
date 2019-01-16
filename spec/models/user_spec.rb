require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.new(user_attributes) }
  context 'valid record' do
    it "should be valid" do
      expect user.valid?
    end

    it "name should be present" do
      user.name = "     "
      expect( user.valid? ).to be_falsey
    end

    it "email should be present" do
      user.email_address = "     "
      expect( user.valid? ).to be_falsey
    end

    it "google id should be present" do
      user.google_id = "     "
      expect( user.valid? ).to be_falsey
    end

    it "name should not be too long" do
      user.name = "a" * 51
      expect( user.valid? ).to be_falsey
    end

    it "email should not be too long" do
      user.email_address = "a" * 244 + "@example.com"
      expect( user.valid? ).to be_falsey
    end

    it "email validation should accept valid addresses" do
      valid_addresses = %w[testuser@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email_address = valid_address
        expect( user.valid? ).to be_truthy, "#{valid_address.inspect} should be valid"
      end
    end

    it "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email_address = invalid_address
        expect( user.valid? ).to be_falsey, "#{invalid_address.inspect} should be invalid"
      end
    end

    it "email addresses should be unique" do
      duplicate_user = user.dup
      duplicate_user.email_address = user.email_address.upcase
      user.save
      expect( duplicate_user.valid? ).to be_falsey
    end

    it "google id should be unique" do
      duplicate_user = user.dup
      duplicate_user.google_id = user.google_id
      user.save
      expect( duplicate_user.valid? ).to be_falsey
    end

  end

end
