class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]  # Deviseのメソッドでログイン必須制御
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_active_hash_data, only: [:new, :create]

  def new
    @item = Item.new
  end

  def index
    @items = Item.all.includes(:user,image_attachment: :blob).order(created_at: :desc)
    @show_dummy = @items.empty?
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user  

    if @item.save
      redirect_to root_path, notice: "出品が完了しました"
    else
      set_active_hash_data
      render :new
    end
  end

  #def destroy
    #@item = Item.find(params[:id])
    #@item.destroy
    #redirect_to root_path, notice: "商品を削除しました"
  #end

  private

  def item_params
    params.require(:item).permit(
    :image, :name, :description, :category_id, :condition_id,
    :shipping_fee_id, :prefecture_id, :shipping_day_id, :price
    )
  end


  def set_active_hash_data
    @categories = Category.all
    @conditions = Condition.all
    @shipping_fees = ShippingFee.all
    @prefectures = Prefecture.all
    @shipping_days = ShippingDay.all
  end
end