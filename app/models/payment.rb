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
    attributes = %w{id transaction_id user_name user_email amount_paid result_message est_created_at}

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

  scope :for_current_registration_period, ->(date=DateTime.parse('201910010000')) { where(transaction_date: date.strftime("%Y%m%d%H%M")..(date + 11.months).strftime("%Y%m%d%H%M")) }

end
