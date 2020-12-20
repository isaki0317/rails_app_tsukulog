FactoryBot.define do
  factory :chat do
    message { Faker::Lorem.characters(number:20) }
    end_user
    room
  end
end