class Api::V1::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
    merch1 = Merchant.find(params[:id])
  # binding.pry
    render json: merch1
  end

end

# GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
