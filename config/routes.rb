Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: 'admins' do
    resources :pending_traders, only: :index
    resources :approved_traders, only: :create
    resources :traders
    resources :transactions, only: :index, as: 'admin_transactions'
  end

  scope module: 'traders' do
    resources :stocks, only: :index, path: 'portfolio', as: 'trader_stocks'

    resources :buy_transactions, only: :create, path: 'buy'
    get 'buy/:symbol', to: 'buy_transactions#new', as: 'new_buy_transaction'

    resources :sell_transactions, only: :create, path: 'sell'
    get 'sell/:symbol', to: 'sell_transactions#new', as: 'new_sell_transaction'

    resources :transactions, only: :index, as: 'trader_transactions', path: 'portfolio/transactions'

    resources :search_stocks, only: %i[new create]
  end

  root 'static_pages#home'
end
