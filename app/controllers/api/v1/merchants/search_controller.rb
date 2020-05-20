class Api::V1::Merchants::SearchController < ApplicationController
  def show
    merchants = Merchant.where(nil)
    filtering_params(params).each do |key, value|
      @grouped_merchants = merchants.public_send("by_#{key}", value) if value.present?
    end
    merchant = @grouped_merchants.first
    render json: MerchantSerializer.new(merchant)
  end

  def index
    merchants = Merchant.where(nil)
    filtering_params(params).each do |key, value|
      @grouped_merchants = merchants.public_send("by_#{key}", value) if value.present?
    end
    render json: MerchantSerializer.new(@grouped_merchants)
  end

  def most_revenue
    @merchants = Merchant.find_most_revenue(params[:quantity])
    render json: MerchantSerializer.new(@merchants)
  end

  def most_items
    @merchants = Merchant.find_most_items(params[:quantity])
    render json: MerchantSerializer.new(@merchants)
  end

  def total_revenue
    @merchant = Merchant.find(params[:id])
    revenue = @merchant.find_total_revenue(params[:id])
    revenue_render = render json: revenue
    json = JSON.parse(revenue_render, symbolize_names: true)
    json[0][:revenue].to_f
  end

  private

  def filtering_params(params)
    params.slice(:name, :created_at, :updated_at)
  end
end
