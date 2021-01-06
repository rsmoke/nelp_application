class PagesController < ApplicationController

  def index
    if user_signed_in?
      redirect_to all_payments_path
    end
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def terms_of_service
  end
end
