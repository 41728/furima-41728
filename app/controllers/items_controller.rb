class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]
  before_action :set_active_hash_data, only: [:new, :create, :edit, :update]

  def new
    @item = Item.new
  end

  def index
    @items = Item.all.includes(:user, image_attachment: :blob).order(created_at: :desc)
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

  def show
  end

  def edit
    
  end

  def update
    if params[:item][:image].blank? && !@item.image.attached?
      @item.errors.add(:image, "を追加してください")
      set_active_hash_data

      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
      return
    end

    if @item.update(item_params)
      redirect_to item_path(@item), notice: "商品情報を変更しました"
    else
      set_active_hash_data
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    if current_user.id != @item.user_id || @item.sold_out?
      redirect_to root_path, alert: "編集権限がありません"
    end
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id,
      :shipping_fee_id, :prefecture_id, :shipping_day_id, :price,
      image: []  
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
