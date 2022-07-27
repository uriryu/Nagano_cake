class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customers = Customer.all
  end

  def edit
  end

  def unsubscribe
  end
end
