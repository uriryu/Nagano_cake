class Public::ItemsController < ApplicationController
  
  
  def index
    @genres = Genre.all
    @items = Item.all
    
    if params[:genre_id].present?
      # presentメソッドでparams[:genre_id]に値が含まれているか確認　=> trueの場合下記を実行
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
    @genres = Genre.all
  end
  
  
  
  # private
  # def item_params
    # params.require(:item).permit(:image)  
  # end
end
