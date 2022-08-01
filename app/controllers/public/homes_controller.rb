class Public::HomesController < ApplicationController
 
 
  def top
   # @genres = Genre.all
   # @genre = Genre.find(params[:id])
   @items = Item.all.page(params[:page]).per(4)
   
   @genres = Genre.all
  end

  def about
  end
end
