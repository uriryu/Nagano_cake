class Admin::HomesController < ApplicationController
  def top
    @order = Order.page(params[:page])
    
  end
  
  def about
  end
  
end
