require 'rails_helper'

RSpec.describe Payment, type: :model do
  user = User.create(user_attributes)
  subject { described_class.new(payment_attributes(user: user)) }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a transactionType" do
    subject.transactionType = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transactionStatus" do
    subject.transactionStatus = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transactionId" do
    subject.transactionId = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a unique transactionId" do
    user = User.create(user_attributes)
    subject1 = Payment.create!(payment_attributes(user: user, transactionId: "1234567890"))
    subject2 = Payment.new(payment_attributes(user: user, transactionId: "1234567890"))
    expect(subject2).to_not be_valid
  end

  it "is not valid without a transactionTotalAmount" do
    subject.transactionTotalAmount = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transactionDate" do
    subject.transactionDate = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transactionAcountType" do
    subject.transactionType = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transactionResultCode" do
    subject.transactionResultCode = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transactionResultMessage" do
    subject.transactionResultMessage = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a orderNumber" do
    subject.orderNumber = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a payerFullName" do
    subject.payerFullName = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a timestamp" do
    subject.timestamp = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a transactionHash" do
    subject.transactionHash = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a unique transactionHash" do
    user = User.create(user_attributes)
    subject1 = Payment.create!(payment_attributes(user: user, transactionHash: "63d042588e873b698ff8c04"))
    subject2 = Payment.new(payment_attributes(user: user, transactionHash: "63d042588e873b698ff8c04"))
    expect(subject2).to_not be_valid
  end

  it "belongs to a user" do
    user = User.create(user_attributes)

    user.payments.new(payment_attributes)

    expect(subject.user).to eq(user)
  end

end
