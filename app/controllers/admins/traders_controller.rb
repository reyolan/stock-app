class Admins::TradersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_trader, only: %i[edit update show]

  def index
    @traders = User.traders
  end

  def show
    @trader = User.traders.find(params[:id])
  end

  def new
    @trader = User.new
  end

  def create
    @trader = User.new(trader_params)
    if @trader.save_trader
      redirect_to traders_path, notice: 'Trader was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @trader.update(trader_update_params)
      UserMailer.with(user: @trader).account_approval_email.deliver_now
      redirect_to traders_path(@trader), notice: 'Trader details was successfully updated.'
    else
      render :edit
    end
  end

  private

  def trader_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def trader_update_params
    params.require(:user).permit(:email, :approved)
  end

  def set_trader
    @trader = User.traders.find(params[:id])
  end
end
