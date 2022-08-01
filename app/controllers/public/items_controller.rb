class Public::ItemsController < ApplicationController
  
  
  def index
    @genres = Genre.all
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end
  
  
  
  # private
  # def item_params
    # params.require(:item).permit(:image)  
  # end
end
