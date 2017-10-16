FactoryGirl.define do
  factory :product do
    name     { Faker::Name.name }
    price         { Faker::Number.decimal(3, 2) }
    quantity  { Faker::Number.between(1, 20) }
    category       { ['Apparel', 'Electronics', 'Furniture'].sample }
  end
end