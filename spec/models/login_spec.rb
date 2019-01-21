require 'rails_helper'

RSpec.describe Login, type: :model do

  context 'valid record' do

    it "requires a name" do
      login = Login.new(name: "")

      login.valid? # populates errors

      expect(login.errors[:name].any?).to eq(true)
    end

    it "requires a google_id" do
      login = Login.new(google_id: "")

      login.valid? # populates errors

      expect(login.errors[:google_id].any?).to eq(true)
    end

    it "requires an email_address" do
      login = Login.new(email_address: "")

      login.valid? # populates errors

      expect(login.errors[:email_address].any?).to eq(true)
    end

    it "email should not be too long" do
      login = Login.new
      login.email_address = "a" * 244 + "@example.com"
      expect( login.valid? ).to be_falsey
    end

    it "email validation should accept valid addresses" do
      user = User.create!(umich_user_attributes)
      login = Login.new(login_attributes(user: user))
      valid_addresses = %w[testuser@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        login.email_address = valid_address
        expect( login.valid? ).to be_truthy, "#{valid_address.inspect} #{login.errors.full_messages} should be valid"
      end
    end

    it "email validation should reject invalid addresses" do
      user = User.create!(umich_user_attributes)
      login = Login.new(login_attributes(user: user))
      invalid_addresses = %w[user@example,com user_at_foo.org someone.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        login.email_address = invalid_address
        expect( login.valid? ).to be_falsey, "#{invalid_address.inspect} should be invalid"
      end
    end

    it "email addresses should be unique" do
      user = User.create!(umich_user_attributes)
      login = Login.new(login_attributes(user: user))
      duplicate_login = login.dup
      duplicate_login.email_address = login.email_address.upcase
      login.save
      expect( duplicate_login.valid? ).to be_falsey
    end

    it "google id should be unique" do
      user = User.create!(umich_user_attributes)
      login = Login.new(login_attributes(user: user))
      duplicate_login = login.dup
      duplicate_login.google_id = login.google_id
      login.save
      expect( duplicate_login.valid? ).to be_falsey
    end

    it "is valid with example attributes" do
      user = User.create!(umich_user_attributes)
      login = Login.new(login_attributes(user: user))
      expect(login.valid?).to eq(true)
    end

    it "belongs to a user" do
      user = User.create!(umich_user_attributes)
      login = Login.new(login_attributes(user: user))
      user.logins.new(login_attributes)

      expect(login.user).to eq(user)
    end
  end
end
