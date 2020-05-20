class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    render json: ItemSerializer.new(merchant.items.all)
  end

  def show
    merchant_id = Item.find(params[:item_id]).merchant_id
    render json: MerchantSerializer.new(Merchant.find(merchant_id))
  end
end