class ItemsController < ApplicationController
  def show
    @item を取得する
    @item = Item.find(params[:id])
  end
end