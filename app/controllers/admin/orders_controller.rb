class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @order_detail = @order.order_details
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    redirect_to admin_order_path(params[:id])
    # idがupdate時に代わって、違うページに飛んでしまっているshowページのstatus辺りを確認。

  end

  def index
    @orders = Order.all.page(params[:page]).per(10)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
