require 'rails_helper'

describe "Merchants API" do
  it "returns a collection of items associated with that merchant" do

    m1 = create(:merchant)
    i1 = create(:item, merchant_id: m1.id)
    i2 = create(:item, merchant_id: m1.id)
    i3 = create(:item, merchant_id: m1.id)

    get "/api/v1/merchants/#{m1.id}/items"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(m1.items.count).to eq(3)
  end

end
