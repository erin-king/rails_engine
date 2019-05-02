require 'rails_helper'

RSpec.describe Merchant, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'class methods' do
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

    it '.top_merchants_by_total_revenue(limit)' do
      actual = Merchant.top_merchants_by_total_revenue(3)
      expect(actual).to eq([@m2, @m3, @m4])
    end
  end
end
