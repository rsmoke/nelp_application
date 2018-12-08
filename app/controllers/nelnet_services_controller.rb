require 'digest'
require 'time'

class NelnetServicesController < ApplicationController
  before_action :current_user,   only: %i[payment_receipt make_payment]

  def payment_receipt
    # params.each do |key,value|
    #   Rails.logger.warn "Param #{key}: #{value}"
    # end
    Payment.create(
      transactionType: params['transactionType'],
      transactionStatus: params['transactionStatus'],
      transactionId: params['transactionId'],
      transactionTotalAmount: params['transactionTotalAmount'],
      transactionDate: params['transactionDate'],
      transactionAcountType: params['transactionAcountType'],
      transactionResultCode: params['transactionResultCode'],
      transactionResultMessage: params['transactionResultMessage'],
      orderNumber: params['orderNumber'],
      payerFullName: @current_user.google_id,
      timestamp: params['timestamp'],
      transactionHash: params['hash']
    )

    @current_payment = Payment.find_by(transactionId: params[:transactionId])

  end

  def make_payment
    processed_url = generate_hash(@current_user)
    redirect_to processed_url
  end

  private
    def generate_hash(current_user)
      order_num = current_user.email_address.partition('@').first + '-' + current_user.id.to_s
      redirect_url = 'https://lsa-english-nelp.miserver.it.umich.edu/payment_receipt'
      amount_to_be_payed = 35
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
        'orderNumber' => order_num,
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
      params.permit(:transactionType, :transactionStatus, :transactionId, :transactionTotalAmount, :transactionDate, :transactionAcountType, :transactionResultCode, :transactionResultMessage, :orderNumber, :timestamp, :hash)
    end
end
