class Merchant < ApplicationRecord

  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.top_merchants_by_total_revenue(limit)
    select('merchants.name, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(items: :invoice_items)
    .group(:id)
    .order('revenue desc')
    .limit(limit)
  end





end
