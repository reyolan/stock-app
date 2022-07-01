class BalanceTransaction < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true, numericality: { greater_than: 0 }

  enum transaction_type: %i[deposit withdraw]
end