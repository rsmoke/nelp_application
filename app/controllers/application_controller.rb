class ApplicationController < ActionController::Base
  include LoginsHelper

private
  def user_has_payments?(user)
    # return true unless Payment.find_by(user_id: user).nil?
    if Payment.for_current_registration_period.find_by(user_id: user).nil?
      false
    else
      true
    end
  end

  helper_method :user_has_payments?
end
