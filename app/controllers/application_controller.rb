class ApplicationController < ActionController::Base
  def welcome
    render plain: 'Welcome to Etf Basket App'
  end
end
