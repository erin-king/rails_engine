class Api::V1::MerchantsController < ApplicationController

  def index
    render json: Merchant.all
  end

  def show
  #   merch1 = Merchant.find(params[:id])
  # # binding.pry
  #   render json: merch1
  end

end
