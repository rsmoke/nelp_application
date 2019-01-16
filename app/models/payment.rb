class Payment < ApplicationRecord
  belongs_to :user

  validates_presence_of :transactionType, :transactionStatus, :transactionId,
                        :transactionTotalAmount, :transactionDate,
                        :transactionAcountType, :transactionResultCode,
                        :transactionResultMessage, :orderNumber, :payerFullName,
                        :timestamp, :transactionHash
end
