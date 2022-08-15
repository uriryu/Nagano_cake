class Admin::ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @items = Item.all.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    item.save!
    redirect_to admin_items_path
  end

  def show
    @item = Item.find(params[:id])
  end


  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "編集できました"
      redirect_to admin_item_path(@item.id)
    else
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :image, :is_active)
  end
end
