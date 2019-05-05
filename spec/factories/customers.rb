FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "Customer #{n}" }
    last_name { "Lastname" }
  end
end
