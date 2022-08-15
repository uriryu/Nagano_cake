class Admin::HomesController < ApplicationController
  def top
    @order_details = OrderDetail.page(params[:page])
    
  end
  
  def about
  end
  
end
