class Admin::OrdersDetailsController < ApplicationController

  def index
    @order_detail = OrderDetail.find(params[:id])
    @order_details = OrderDetail.all
  end

end
