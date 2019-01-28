class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :transactionType, :transaction_type
    rename_column :payments, :transactionStatus, :transaction_status
    rename_column :payments, :transactionId, :transaction_id
    rename_column :payments, :transactionTotalAmount, :total_amount
    rename_column :payments, :transactionDate, :transaction_date
    rename_column :payments, :transactionAcountType, :account_type
    rename_column :payments, :transactionResultCode, :result_code
    rename_column :payments, :transactionResultMessage, :result_message
    rename_column :payments, :orderNumber, :user_account
    rename_column :payments, :payerFullName, :payer_identity
    rename_column :payments, :transactionHash, :transaction_hash
  end
end
