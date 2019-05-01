class Api::V1::ItemsController < ApplicationController

  def index
    # merchant = Merchant.find(params[:merchant_id])
    # render json: merchant.items
    render json: Item.where(merchant_id: params[:merchant_id])
  end

end
