class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
  end

  def show
  end
  
  
  # private
  # def item_params
    # params.require(:item).permit(:image)  
  # end
end
