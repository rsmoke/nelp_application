class LoginsController < ApplicationController
  def new
  end

  def create
    if user = authenticate_with_google
      cookies.signed[:user_id] = user.id
      Login.create(email_address: user.email_address, name: user.name, google_id: GoogleSignIn::Identity.new(flash[:google_sign_in_token]).user_id, user_id: user.id)
      @user = User.find_by(google_id: GoogleSignIn::Identity.new(flash[:google_sign_in_token]).user_id)
      if @user
        log_in @user
        if current_user_admin?
          redirect_to admin_payments_path
        else
          redirect_to all_payments_path
        end
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
    def login_params
      params.permit(:id, :name, :google_id, :email_address, :user_id)
    end

    # def authenticate_with_google
    #   logger.debug "*** HZ THERE *** google_sign_in PRESENT: #{flash[:google_sign_in]}"
    #   if id_token = flash[:google_sign_in][:id_token]
    #     logger.debug "*** HZ THERE *** google_sign_in PRESENT: #{id_token}"
    #     User.find_or_create_by(google_id: GoogleSignIn::Identity.new(id_token)).user_id do |user|
    #       user.name = GoogleSignIn::Identity.new(flash[:google_sign_in][:id_token]).name
    #       user.email_address = GoogleSignIn::Identity.new(flash[:google_sign_in][:id_token]).email_address
    #       user.avatar_url = GoogleSignIn::Identity.new(flash[:google_sign_in][:id_token]).avatar_url
    #       user.locale = GoogleSignIn::Identity.new(flash[:google_sign_in][:id_token]).locale
    #       user.hosted_domain = GoogleSignIn::Identity.new(flash[:google_sign_in][:id_token]).hosted_domain
    #     end
    #   elsif error = flash[:google_sign_in][:error]
    #     logger.error "Google authentication error: #{error}"
    #     nil
    #   end
    # end

        def authenticate_with_google
          logger.debug "In autheticate_with_google"
          if id_token = flash[:google_sign_in][:id_token]
            logger.debug "***Google authentication: #{flash[:google_sign_in][:id_token]}"
            User.find_by google_id: GoogleSignIn::Identity.new(id_token).user_id
          elsif error = flash[:google_sign_in][:error]
            logger.error "Google authentication error: #{error}"
            nil
          end
        end
end
