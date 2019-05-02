class Api::V1::Merchants::SearchController < ApplicationController

  def index

  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))

  end

end

# description
# id	search based on the primary key
# name	search based on the name attribute
# created_at	search based on created_at timestamp
# updated_at	search based on updated_at timestamp
#
