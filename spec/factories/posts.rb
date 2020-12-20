FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:10) }
    subtitle { Faker::Lorem.characters(number:16) }
    images { File.new("#{Rails.root}/spec/factories/test.jpg") }
    genre
    end_user
    # association :material
    # association :work
  end
end