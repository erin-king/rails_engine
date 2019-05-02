class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  attributes :name
end
