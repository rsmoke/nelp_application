class Payment < ApplicationRecord
  belongs_to :user

  validates_presence_of :transactionType, :transactionStatus,
                        :transactionTotalAmount, :transactionDate,
                        :transactionAcountType, :transactionResultCode,
                        :transactionResultMessage, :orderNumber, :payerFullName,
                        :timestamp

  validates :transactionId, presence: true, uniqueness: true
  validates :transactionHash, presence: true, uniqueness: true
end
