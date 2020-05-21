class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    @merchants = Merchant.find_most_revenue(params[:quantity])
    render json: MerchantSerializer.new(@merchants)
  end

  def show
    @merchant = Merchant.find(params[:id])
    revenue = @merchant.find_total_revenue(params[:id])
    data = {
        "data" => {
            "id" => "null",
            "attributes" => revenue
        }
    }
    render json: data
  end
end
