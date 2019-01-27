require "administrate/base_dashboard"

class PaymentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.

  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    id: Field::Number,
    transaction_type: Field::String,
    transaction_status: Field::String,
    transaction_id: Field::String,
    total_amount: Field::String,
    transaction_date: Field::String,
    account_type: Field::String,
    result_code: Field::String,
    result_message: Field::String,
    user_account: Field::String,
    payer_identity: Field::String,
    timestamp: Field::String,
    transaction_hash: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :user,
    :user_account,
    :id,
    :total_amount,
    :transaction_status,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :user,
    :id,
    :transaction_type,
    :transaction_status,
    :transaction_id,
    :total_amount,
    :transaction_date,
    :account_type,
    :result_code,
    :result_message,
    :user_account,
    :payer_identity,
    :timestamp,
    :transaction_hash,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :user,
    :transaction_type,
    :transaction_status,
    :transaction_id,
    :total_amount,
    :transaction_date,
    :account_type,
    :result_code,
    :result_message,
    :user_account,
    :payer_identity,
    :timestamp,
    :transaction_hash,
  ].freeze

  # Overwrite this method to customize how payments are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(payment)
    "Payment ##{payment.id} for $#{payment.total_amount.to_f / 100 }0"
  end
end
