# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include LoginsHelper
    before_action :authenticate_admin

    def authenticate_admin
      # TODO Add authentication logic here.
      require_admin
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

  private
    def require_admin
      unless current_user_admin?
        redirect_to root_url, alert: "Unauthorized access!"
      end
    end

    def current_user_admin?
      current_user && current_user.admin?
    end

    helper_method :current_user_admin?
  end
end
