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
      @i1 = create(:item, merchant: @m1)
      @i2 = create(:item, merchant: @m2)
      @i3 = create(:item, merchant: @m2)
      @i4 = create(:item, merchant: @m2)
      @i5 = create(:item, merchant: @m3)
      @i6 = create(:item, merchant: @m4)
    end

    xit '.top_merchants_by_total_revenue(limit)' do
      actual = Merchant.top_merchants_by_total_revenue(3)
      expect(actual).to eq()
    end
  end
end
