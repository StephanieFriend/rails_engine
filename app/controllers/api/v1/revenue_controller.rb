class Api::V1::RevenueController < ApplicationController

  def show
    revenue = Invoice.total_revenue(params[:start], params[:end])
    data = {
        "data" => {
            "id" => "null",
            "attributes" => {
                "revenue"  => revenue
            }
        }
    }
   render json: data
  end
end
