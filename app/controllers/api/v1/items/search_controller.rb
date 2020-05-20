class Api::V1::Items::SearchController < ApplicationController
  def show
    items = Item.where(nil)
    filtering_params(params).each do |key, value|
      @grouped_items = items.public_send("by_#{key}", value) if value.present?
    end
    item = @grouped_items.first
    render json: ItemSerializer.new(item)
  end

  def index
    items = Item.where(nil)
    filtering_params(params).each do |key, value|
      @grouped_items = items.public_send("by_#{key}", value) if value.present?
    end
    render json: ItemSerializer.new(@grouped_items)
  end

  private

  def filtering_params(params)
    params.slice(:name, :description, :created_at, :updated_at, :unit_price, :merchant_id)
  end

end

