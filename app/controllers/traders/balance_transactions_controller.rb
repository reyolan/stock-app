class Traders::BalanceTransactionsController < ApplicationController
  before_action :authenticate_approved_trader

  def index
    @balance_transactions = current_user.balance_transactions.desc_created_at.page(params[:page])
  end
end
class Traders::BalanceTransactionsController < ApplicationController
  before_action :authenticate_approved_trader

  def index
    @balance_transactions = current_user.balance_transactions.desc_created_at.page(params[:page])
  end
end