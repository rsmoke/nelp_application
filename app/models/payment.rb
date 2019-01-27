class Payment < ApplicationRecord
  belongs_to :user

  validates_presence_of :transaction_type, :transaction_status,
                        :total_amount, :transaction_date,
                        :account_type, :result_code,
                        :result_message, :user_account, :payer_identity,
                        :timestamp

  validates :transaction_id, presence: true, uniqueness: true
  validates :transaction_hash, presence: true, uniqueness: true
end
