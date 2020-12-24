FactoryBot.define do
  factory :end_user, aliases: [:following, :follower, :visited, :visitor, :blocker, :blocked] do
    name { Faker::Lorem.characters(number: 8) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    address { Faker::Lorem.characters(number: 12) }
    introduction { Faker::Lorem.characters(number: 20) }
    # images { [ Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/test.jpg'), 'spec/factories/test.jpg') ] }
  end
end
