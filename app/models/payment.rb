class Payment < ApplicationRecord
  belongs_to :user

  validates_presence_of :transaction_type, :transaction_status,
                        :total_amount, :transaction_date,
                        :account_type, :result_code,
                        :result_message, :user_account, :payer_identity,
                        :timestamp

  validates :transaction_id, presence: true, uniqueness: true
  validates :transaction_hash, presence: true, uniqueness: true

  def self.to_csv
    attributes = %w{id user_name user_email amount_paid est_created_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def user_email
    user.email_address
  end

  def user_name
    user.name
  end

  def amount_paid
    total_amount.chomp('00')
  end

  def est_created_at
    (created_at + Time.zone_offset('EST')).strftime("%F %T")
  end

end
