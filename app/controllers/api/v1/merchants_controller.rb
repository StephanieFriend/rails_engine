class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render_json(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render_json(merchant)
  end

  def create
    merchant = Merchant.create(merchant_params)
    render_json(merchant)
  end

  def update
    merchant = Merchant.update(params[:id], merchant_params)
    render_json(merchant)
  end

  def destroy
    merchant = Merchant.destroy(params[:id])
    render_json(merchant)
  end

  private

  def merchant_params
    params.permit(:name)
  end

  def render_json(merchant)
    render json: MerchantSerializer.new(merchant).serializable_hash
  end
end