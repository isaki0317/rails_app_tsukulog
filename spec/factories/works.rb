FactoryBot.define do
  factory :work do
    detail { Faker::Lorem.characters(number:30) }
    images { File.new("#{Rails.root}/spec/factories/test.jpg") }
    post
  end
end