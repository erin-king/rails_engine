FactoryBot.define do
  factory :item do
    merchant { nil }
    name { "Item Name" }
    description { "Description" }
    unit_price { 1 }
  end
end
