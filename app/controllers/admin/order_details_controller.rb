class Admin::OrderDetailsController < ApplicationController

  def index
    @order_detail = OrderDetail.find(params[:order_id])
    @order_details = OrderDetail.all
  end
  
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    redirect_to admin_order_path(params[:id])
    # redirect_toをorder_idではなく、普通の:idにすることで同じページのidを持ってこれた。
  end
  
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
