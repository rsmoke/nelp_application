class NelnetServicesController
  def initialize(params)
    @amount
    @email
  end

  def charge
    begin
      # This will return a NelnetService::Charge object
      external_charge_service.create(charge_attributes)
    rescue
      false
    end
  end

  def create_customer
    begin
      # This will return a Nelnet::Customer object
      external_customer_service.create(customer_attributes)
    rescue
      false
    end
  end

  private

  attr_reader :card, :amount, :email

  def external_charge_service
    Stripe::Charge
  end

  def external_customer_service
    Stripe::Customer
  end

  def charge_attributes
    {
      amount: amount,
      card: card
    }
  end

  def customer_attributes
    {
      email: email,
      card: card
    }
  end
end
