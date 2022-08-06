class Admin::OrdersController < ApplicationController
 
  def show
    @order = Order.find(params[:id])
    
    @order_details = OrderDetail.all
    @order_detail = OrderDetail.find(params[:id])
    @details = @order_detail.item
    
    @total = 0
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(order.id)
    
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    redirect_to admin_order_path(order.id)
  end
  
  def index
    @orders = Order.all
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
  
end
