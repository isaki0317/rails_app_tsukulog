FactoryBot.define do
  factory :contact do
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:50) }
    end_user
  end
end