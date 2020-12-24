FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.characters(number: 20) }
    end_user
    post
  end
end
