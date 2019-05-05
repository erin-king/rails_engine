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

  it "returns one merchant at random" do
    m1 = create(:merchant)
    m1 = create(:merchant)

    get "/api/v1/merchants/random"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    merchant = merchants["data"]

    expect(merchant).to have_key("id")
    expect(merchant).to have_key("type")
    expect(merchant).to have_key("attributes")
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

  describe 'business intelligence' do
    before :each do
      @m1 = create(:merchant)
      @m2 = create(:merchant)
      @m3 = create(:merchant)
      @m4 = create(:merchant)
      @m5 = create(:merchant)
      @c1 = create(:customer)
      @c2 = create(:customer)
      @c3 = create(:customer)
      @c4 = create(:customer)
      @c5 = create(:customer)
      @item1 = create(:item, merchant: @m1)
      @item2 = create(:item, merchant: @m2)
      @item3 = create(:item, merchant: @m2)
      @item4 = create(:item, merchant: @m2)
      @item5 = create(:item, merchant: @m3)
      @item6 = create(:item, merchant: @m4)
      @invoice1 = create(:invoice, merchant: @m1, customer: @c1)
      @invoice2 = create(:invoice, merchant: @m1, customer: @c2)
      @invoice3 = create(:invoice, merchant: @m2, customer: @c3)
      @invoice4 = create(:invoice, merchant: @m2, customer: @c4)
      @invoice5 = create(:invoice, merchant: @m3, customer: @c5)
      @invoice6 = create(:invoice, merchant: @m4, customer: @c5)
      @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, quantity: 1, unit_price: 10)
      @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice3, quantity: 1, unit_price: 10)
      @invoice_item3 = create(:invoice_item, item: @item4, invoice: @invoice4, quantity: 1, unit_price: 10)
      @invoice_item5 = create(:invoice_item, item: @item5, invoice: @invoice5, quantity: 2, unit_price: 10)
      @invoice_item6 = create(:invoice_item, item: @item6, invoice: @invoice6, quantity: 1, unit_price: 10)
    end

    it "returns the top x merchants ranked by most revenue" do

      get "/api/v1/merchants/most_revenue?quantity=2"

      merchants = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(merchants[0]["attributes"]["id"]).to eq(@m2.id)
      expect(merchants[1]["attributes"]["id"]).to eq(@m3.id)
      expect(merchants.length).to eq(2)
    end
  end
end
