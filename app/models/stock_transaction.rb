class StockTransaction < ApplicationRecord
  belongs_to :user
  validate :stock_quantity_is_positive, :stock_quantity_scale_is_one

  enum transaction_type: %i[buy sell]

  scope :buy_list, -> { where(transaction_type: 0).order(created_at: :desc) }
  scope :sell_list, -> { where(transaction_type: 1).order(created_at: :desc) }

  def buy_type
    self.transaction_type = 0
    self.amount = quantity * unit_price
    self
  end

  def sell_type
    self.transaction_type = 1
    self.amount = quantity * unit_price
    self
  end

  private

  def stock_quantity_is_positive
    errors.add(:base, 'An input of 0 share is not possible') if quantity.zero?
    errors.add(:base, 'An input of negative share is not possible') if quantity.negative?
  end

  def stock_quantity_scale_is_one
    unless quantity == quantity.round(1)
      errors.add(:base, 'You can only input number of shares up to scale of 1 (e.g. 1, 2, 1.5, 2.5)')
    end
  end
end
