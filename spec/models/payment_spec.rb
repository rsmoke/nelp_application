require 'rails_helper'

RSpec.describe Payment, type: :model do
  user = User.create(user_attributes)
  subject { described_class.new(payment_attributes(user: user)) }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a transaction type" do
    subject.transaction_type = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transaction status" do
    subject.transaction_status = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transaction id" do
    subject.transaction_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a unique transaction id" do
    user = User.create(user_attributes)
    subject1 = Payment.create!(payment_attributes(user: user, transaction_id: "1234567890"))
    subject2 = Payment.new(payment_attributes(user: user, transaction_id: "1234567890"))
    expect(subject2).to_not be_valid
  end

  it "is not valid without a transaction amount" do
    subject.total_amount = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transaction date" do
    subject.transaction_date = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transaction account type" do
    subject.account_type = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transaction result code" do
    subject.result_code = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transaction result message" do
    subject.result_message = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user account" do
    subject.user_account = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a payer identity" do
    subject.payer_identity = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a timestamp" do
    subject.timestamp = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transaction hash" do
    subject.transaction_hash = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a unique transaction hash" do
    user = User.create(user_attributes)
    subject1 = Payment.create!(payment_attributes(user: user, transaction_hash: "63d042588e873b698ff8c04"))
    subject2 = Payment.new(payment_attributes(user: user, transaction_hash: "63d042588e873b698ff8c04"))
    expect(subject2).to_not be_valid
  end

  it "belongs to a user" do
    user = User.create(user_attributes)

    user.payments.new(payment_attributes)

    expect(subject.user).to eq(user)
  end

end
