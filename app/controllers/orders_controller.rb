class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :prevent_sold_out
  #before_action :move_to_root_if_seller

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid? && @order_address.save
      if pay_item
        redirect_to root_path, notice: "購入が完了しました"
      else
        # 決済失敗時の処理（保存済みなので必要に応じてキャンセル処理などを実装）
        flash.now[:alert] = "決済に失敗しました。もう一度お試しください。"
        render :index, status: :unprocessable_entity
      end
    else
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find_by(id: params[:id], item_id: params[:item_id])
    unless @order
      flash[:alert] = "注文が見つかりませんでした。"
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def prevent_sold_out
    redirect_to root_path if @item.order.present? || current_user.id == @item.user_id
  end

  def order_address_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
    charge.paid
  rescue Payjp::CardError => e
    Rails.logger.error "決済エラー: #{e.message}"
    false
  end
end
