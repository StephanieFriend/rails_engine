FactoryBot.define do
  factory :item do
    name { Faker::Movies::HarryPotter.book }
    description { Faker::Movies::HarryPotter.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant
  end
end