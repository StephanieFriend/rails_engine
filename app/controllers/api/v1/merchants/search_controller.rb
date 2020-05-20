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

  private

  def filtering_params(params)
    params.slice(:name, :created_at, :updated_at)
  end
end

