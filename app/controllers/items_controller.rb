class ItemsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]
   def index
    # 商品一覧を取得するなどの処理を書く
  end
  def show
  end

  def new
    @item = Item.new
  end
end