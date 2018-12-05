require 'rails_helper'

RSpec.describe NelnetServicesController, type: :controller do

  describe "GET #payment_receipt" do
    it "returns http success" do
      get :payment_receipt
      expect(response).to have_http_status(:success)
    end
  end

end
