require 'rails_helper'

describe "Merchants API" do
  it "returns all merchants" do

    m1 = create(:merchant)
    m2 = create(:merchant)
    m3 = create(:merchant)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    total_merchants = merchants["data"]

    total_merchants.each do |merchant|
      expect(merchant).to have_key("id")
      expect(merchant).to have_key("type")
      expect(merchant).to have_key("attributes")
      expect(merchant).to_not have_key("created_at")
    end

    one_merchant = total_merchants.first["attributes"]["name"]

    expect(one_merchant).to eq(m1.name)
    expect(total_merchants.count).to eq(3)
  end

  it "returns one merchant by id" do
    m1 = create(:merchant)

    get "/api/v1/merchants/#{m1.id}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    merchant = merchants["data"]

    expect(merchant).to have_key("id")
    expect(merchant).to have_key("type")
    expect(merchant).to have_key("attributes")
    expect(merchant).to_not have_key("created_at")

    expect(merchants.count).to eq(1)
  end

  it "returns one merchant by find parameters" do
    m1 = create(:merchant)
    m2 = create(:merchant)

    get "/api/v1/merchants/find?id=#{m1.id}"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    merchant = merchants["data"]
    expect(merchant["id"]).to eq("#{m1.id}")
    expect(merchant["id"]).to_not eq("#{m2.id}")

    get "/api/v1/merchants/find?name=#{m1.name}"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    merchant = merchants["data"]

    expect(merchant["attributes"]["name"]).to eq("#{m1.name}")
    expect(merchant["attributes"]["name"]).to_not eq("#{m2.name}")

  end

  it "returns an array of merchants by find_all parameters" do
    m1 = create(:merchant, name: "Erin")
    m2 = create(:merchant, name: "Erin")
    m3 = create(:merchant, name: "Ben")

    get "/api/v1/merchants/find_all?name=Erin"

    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    merchant = merchants["data"]

    expect(merchant[0]["attributes"]["name"]).to eq("#{m1.name}")
    expect(merchant[1]["attributes"]["name"]).to eq("#{m2.name}")
    expect(merchant[2]).to eq(nil)
  end

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

  xit "returns the top x merchants ranked by most revenue" do
    get "/api/v1/merchants/most_revenue?quantity=3"

  end
end
