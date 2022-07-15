class Admin::ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to '/admin/items'
  end

  def show
  end

  def edit
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "編集できました"
      redirect_to admin_items_path
    else
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :image, :is_active)
  end
end
