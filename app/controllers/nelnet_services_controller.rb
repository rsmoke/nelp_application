require 'digest'
require 'time'

class NelnetServicesController < ApplicationController
  before_action :current_user,   only: %i[payment_receipt make_payment]

  def payment_receipt
    # @user = User.find_by(id: session[:user_id])
    # @transactionType = params[:transactionType]
    # @transactionStatus = params[:transactionStatus]
    # @transactionId = params[:transactionId]
    # @transactionTotalAmount = params[:transactionTotalAmount]
    # @transactionDate = params[:transactionDate]
    # @transactionAcountType = params[:transactionAcountType]
    # @transactionResultCode = params[:transactionResultCode]
    # @transactionResultMessage = params[:transactionResultMessage]
    # @orderNumber = params[:orderNumber]
    # @payerFullName = params[:payerFullName]

    params.each do |key,value|
      Rails.logger.warn "Param #{key}: #{value}"
    end
    # write to transx table

  end

  def make_payment
    processed_url = generate_hash(@current_user.name)
    redirect_to processed_url
  end

  private
    def generate_hash(current_user_name)
      current_epoch_time = DateTime.now.strftime("%Q").to_i
      user_name = current_user_name
      redirect_url = 'https://lsa-english-nelp.miserver.it.umich.edu/payment_receipt'
      amount_to_be_payed = 35
      if Rails.env.development?
         key_to_use = 'test_key'
         url_to_use = 'test_URL'
       else
         key_to_use = 'prod_key'
         url_to_use = 'prod_URL'
       end

      connection_hash = {
       'test_key' => 'key',
       'test_URL' => 'https://uatquikpayasp.com/umich2/commerce_manager/payer.do?',
       'prod_key' => Rails.application.credentials.NELNET_SERVICE[:PRODUCTION_KEY],
       'prod_URL' => Rails.application.credentials.NELNET_SERVICE[:PRODUCTION_URL]
      }

      initial_hash = {
        'orderNumber' => 4,
        'orderType' => 'English Department Online',
        'orderName' => user_name,
        'orderDescription' => 'NELP Application Fees',
        'amountDue' => amount_to_be_payed * 100,
        'redirectUrl' => redirect_url,
        'redirectUrlParameters' => 'transactionType,transactionStatus,transactionId,transactionTotalAmount,transactionDate,transactionAcountType,transactionResultCode,transactionResultMessage,orderNumber,payerFullName',
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
      params.permit(:transactionType, :transactionStatus, :transactionId, :transactionTotalAmount, :transactionDate, :transactionAcountType, :transactionResultCode, :transactionResultMessage, :orderNumber, :payerFullName)
    end
end
