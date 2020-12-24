FactoryBot.define do
  factory :notification do
    association :visitor
    association :visited
    visitor_id { end_user.id }
    visited_id { end_user.id }
    post
    comment
    room
    chat
    action { Faker::Lorem.characters(number: 8) }
    # following
    # follower
  end
end
