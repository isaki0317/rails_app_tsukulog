FactoryBot.define do
  factory :genre do
    name { Faker::Lorem.characters(number:8) }
    is_active { true }
  end
end