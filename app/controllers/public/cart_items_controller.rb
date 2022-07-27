class Public::CartItemsController < ApplicationController
   before_action :authenticate_customer
   
  def index
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
