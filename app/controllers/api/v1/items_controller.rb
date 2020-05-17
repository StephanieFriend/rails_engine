class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      items = Item.where(merchant_id: params[:merchant_id])
    else
      items = Item.all
    end
    render_json(items)
  end

  def show
    item = Item.find(params[:id])
    render_json(item)
  end

  def create
    item = Item.create(item_params)
    render_json(item)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def render_json(item)
    render json: ItemSerializer.new(item).serializable_hash
  end
end