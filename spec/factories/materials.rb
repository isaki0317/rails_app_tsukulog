FactoryBot.define do
  factory :material do
    material_name { Faker::Lorem.characters(number: 8) }
    shop { Faker::Lorem.characters(number: 8) }
    post
  end
end
