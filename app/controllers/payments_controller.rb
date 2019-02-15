require 'digest'
require 'time'


class PaymentsController < ApplicationController
  before_action :current_user,   only: %i[payment_receipt make_payment payment_show]

  def index
    redirect_to root_url and return unless current_user_admin?
    @payments = Payment.all

    respond_to do |format|
      format.html
      format.csv { send_data @payments.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def payment_receipt
    if Payment.pluck(:transaction_id).include?(params['transactionId'])
      redirect_to all_payments_path
    else
      Payment.create(
        transaction_type: params['transactionType'],
        transaction_status: params['transactionStatus'],
        transaction_id: params['transactionId'],
        total_amount: params['transactionTotalAmount'],
        transaction_date: params['transactionDate'],
        account_type: params['transactionAcountType'],
        result_code: params['transactionResultCode'],
        result_message: params['transactionResultMessage'],
        user_account: params['orderNumber'],
        payer_identity: @current_user.google_id,
        timestamp: params['timestamp'],
        transaction_hash: params['hash'],
        user_id: current_user.id
      )

      redirect_to all_payments_path, notice: "Your Payment Was Successfully Recorded"
    end
  end

  def make_payment
    processed_url = generate_hash(@current_user, params['amount'])
    redirect_to processed_url
  end

  def payment_show
    @total_cost = 535
    @users_current_payments = Payment.where(user_id: current_user )
    @ttl_paid = Payment.where(user_id: current_user, transaction_status: '1').pluck(:total_amount).map(&:to_f).sum / 100
    @balance_due = @total_cost - @ttl_paid
  end

  private
    def generate_hash(current_user, amount=35)
      user_account = current_user.email_address.partition('@').first + '-' + current_user.id.to_s
      redirect_url = 'https://lsa-english-nelp.miserver.it.umich.edu/payment_receipt'
      amount_to_be_payed = amount.to_i
      if Rails.env.development? || current_user.id == 1
         key_to_use = 'test_key'
         url_to_use = 'test_URL'
       else
         key_to_use = 'prod_key'
         url_to_use = 'prod_URL'
       end

      connection_hash = {
       'test_key' => Rails.application.credentials.NELNET_SERVICE[:DEVELOPMENT_KEY],
       'test_URL' => Rails.application.credentials.NELNET_SERVICE[:DEVELOPMENT_URL],
       'prod_key' => Rails.application.credentials.NELNET_SERVICE[:PRODUCTION_KEY],
       'prod_URL' => Rails.application.credentials.NELNET_SERVICE[:PRODUCTION_URL]
      }
      current_epoch_time = DateTime.now.strftime("%Q").to_i
      initial_hash = {
        'orderNumber' => user_account,
        'orderType' => 'English Department Online',
        'orderDescription' => 'NELP Application Fees',
        'amountDue' => amount_to_be_payed * 100,
        'redirectUrl' => redirect_url,
        'redirectUrlParameters' => 'transactionType,transactionStatus,transactionId,transactionTotalAmount,transactionDate,transactionAcountType,transactionResultCode,transactionResultMessage,orderNumber',
        'retriesAllowed' => 1,
        'timestamp' => current_epoch_time,
        'key' => connection_hash[key_to_use]
      }

      # Sample Hash Creation
      hash_to_be_encoded = initial_hash.values.map{|v| "#{v}"}.join('')
      encoded_hash =  Digest::SHA256.hexdigest hash_to_be_encoded

      # Final URL
      url_for_payment = initial_hash.map{|k,v| "#{k}=#{v}&" unless k == 'key'}.join('')
      final_url = connection_hash[url_to_use] + url_for_payment + 'hash=' + encoded_hash
    end

    def url_params
      params.permit(:amount, :transactionType, :transactionStatus, :transactionId, :transactionTotalAmount, :transactionDate, :transactionAcountType, :transactionResultCode, :transactionResultMessage, :orderNumber, :timestamp, :hash)
    end
end
