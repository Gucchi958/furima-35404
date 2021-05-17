class PurchasesController < ApplicationController
  before_action :move_to_index, only: [:index, :create]
  before_action :move_to_index2, only: [:index, :create]
  before_action :move_to_index3, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @purchase_delivery = PurchaseDelivery.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_delivery = PurchaseDelivery.new(purchase_params)
    if @purchase_delivery.valid?
      pay_item
      @purchase_delivery.save
      redirect_to root_path 
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_delivery).permit(:postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end
  
  #ログインしていないと購入画面にいけない
  def move_to_index
    unless user_signed_in? 
       redirect_to new_user_session_path
    end
  end

  #出品者は自分の商品購入画面にいけない
  def move_to_index2
    @item = Item.find(params[:item_id])
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  #ログインしているユーザーは売却済み商品の購入ページにはいけない
  def move_to_index3
    @item = Item.find(params[:item_id])
    if  @item.purchase.present?
      redirect_to root_path
    end
  end


  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    Payjp::Charge.create(
      amount: @item.price, 
      card: purchase_params[:token], 
      currency: 'jpy'       
    )
  end

end
