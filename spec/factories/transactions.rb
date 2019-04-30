FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "2019-04-30 15:10:20" }
    result { "MyString" }
  end
end
