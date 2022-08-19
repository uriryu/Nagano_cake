class Public::ItemsController < ApplicationController

  def search
    @items = Item.search(params[:keyword])
    @keyword = params[:keyword]
    render "search"
  end

  def index
    @genres = Genre.all
    @items = Item.all.page(params[:page]).per(4)

    if params[:genre_id].present?
      # presentメソッドでparams[:genre_id]に値が含まれているか確認　=> trueの場合下記を実行
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page]).per(4)
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
