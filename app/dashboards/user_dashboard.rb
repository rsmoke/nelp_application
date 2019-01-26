require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    payments: Field::HasMany,
    logins: Field::HasMany,
    id: Field::Number,
    google_id: Field::String,
    name: Field::String,
    email_address: Field::String,
    avatar_url: Field::String,
    locale: Field::String,
    hosted_domain: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    remember_digest: Field::String,
    admin: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :email_address,
    :payments,
    :logins,
    :id,
    :google_id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :payments,
    :logins,
    :id,
    :google_id,
    :name,
    :email_address,
    :avatar_url,
    :locale,
    :hosted_domain,
    :created_at,
    :updated_at,
    :remember_digest,
    :admin,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :payments,
    :logins,
    :google_id,
    :name,
    :email_address,
    :avatar_url,
    :locale,
    :hosted_domain,
    :remember_digest,
    :admin,
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
  def display_resource(user)
    ": #{user.name}"
  end


end
