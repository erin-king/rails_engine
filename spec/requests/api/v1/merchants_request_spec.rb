require 'rails_helper'

describe "Merchants API" do
  it "returns a collection of items associated with that merchant" do

    m1 = create(:merchant)
    i1 = create(:item, merchant_id: m1.id)
    i2 = create(:item, merchant_id: m1.id)
    i3 = create(:item, merchant_id: m1.id)

    get "/api/v1/merchants/#{m1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  it "returns a collection of invoices associated with a merchant from their known orders" do

    m1 = create(:merchant)
    c1 = create(:customer)
    i1 = create(:invoice, merchant_id: m1.id, customer_id: c1.id)
    i2 = create(:invoice, merchant_id: m1.id, customer_id: c1.id)
    i3 = create(:invoice, merchant_id: m1.id, customer_id: c1.id)

    get "/api/v1/merchants/#{m1.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  it "returns the top x merchants ranked by total revenue" do
    get "/api/v1/merchants/most_revenue?quantity=x"
  end
end
