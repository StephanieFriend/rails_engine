class Api::V1::ItemsController < ApplicationController
  def index
   items = Item.all
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

  def update
    item = Item.update(params[:id], item_params)
    render_json(item)
  end

  def destroy
    item = Item.destroy(params[:id])
    render_json(item)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def render_json(item)
    render json: ItemSerializer.new(item)
  end
end