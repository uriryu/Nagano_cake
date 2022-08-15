class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])

    @order_details = OrderDetail.all
    @order_detail = OrderDetail.find(params[:id])
    @details = @order_detail.item
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(params[:id])
    # idがupdate時に代わって、違うページに飛んでしまっているshowページのstatus辺りを確認。

  end

  def index
    @orders = Order.all
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
