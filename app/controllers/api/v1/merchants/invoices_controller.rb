class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    # merchant = Merchant.find(params[:merchant_id])
    # render json: merchant.invoices
    render json: Invoice.where(merchant_id: params[:merchant_id])
  end

end
