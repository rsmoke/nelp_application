class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :transactionType
      t.string :transactionStatus
      t.string :transactionId
      t.string :transactionTotalAmount
      t.string :transactionDate
      t.string :transactionAcountType
      t.string :transactionResultCode
      t.string :transactionResultMessage
      t.string :orderNumber
      t.string :payerFullName
      t.string :timestamp
      t.string :transactionHash

      t.timestamps
    end
  end
end
