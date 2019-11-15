module Admin
  class PaymentsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Payment.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Payment.find_by!(slug: param)
    # end

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    def scoped_resource
    #  if current_user.super_admin?
    #    resource_class
    #  else
      resource_class.for_current_registration_period
    #  end
    end


    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
