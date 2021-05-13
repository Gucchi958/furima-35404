class PurchasesController < ApplicationController
  before_action :move_to_index, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @purchase_delivery = PurchaseDelivery.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_delivery = PurchaseDelivery.new(purchase_params)
    if @purchase_delivery.valid?
      @purchase_delivery.save
      redirect_to root_path 
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_delivery).permit(:postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  def move_to_index
    unless user_signed_in?
       redirect_to root_path
    end
  end

end
