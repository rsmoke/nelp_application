class LoginsController < ApplicationController
  def new
  end

  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      Login.create(email_address: user.email_address, name: user.name, google_id: GoogleSignIn::Identity.new(flash[:google_sign_in_token]).user_id)
      @user = User.find_by(google_id: GoogleSignIn::Identity.new(flash[:google_sign_in_token]).user_id)
      if @user
        log_in @user
        redirect_to user_path(cookies.signed[:user_id]), alert: "Welcome #{user.name} at #{user.hosted_domain}"
      else
        redirect_to root_url, alert: 'There was problem finding your account'
      end
    else
      redirect_to root_url, alert: 'Google Authentication_failed'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
    def authenticate_with_google
      if flash[:google_sign_in_token].present?
        User.find_or_create_by(google_id: GoogleSignIn::Identity.new(flash[:google_sign_in_token]).user_id) do |user|
          user.name = GoogleSignIn::Identity.new(flash[:google_sign_in_token]).name
          user.email_address = GoogleSignIn::Identity.new(flash[:google_sign_in_token]).email_address
          user.avatar_url = GoogleSignIn::Identity.new(flash[:google_sign_in_token]).avatar_url
          user.locale = GoogleSignIn::Identity.new(flash[:google_sign_in_token]).locale
          user.hosted_domain = GoogleSignIn::Identity.new(flash[:google_sign_in_token]).hosted_domain
        end
      end
    end
end
