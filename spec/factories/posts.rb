FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:10) }
    subtitle { Faker::Lorem.characters(number:16) }
    images { File.new("#{Rails.root}/spec/factories/test.jpg") }
    genre
    end_user

    trait :with_nested_instances do
      after( :create ) do |post|
        create :work, id: post.id
      end
      after( :create ) do |post|
        create :material, id: post.id
      end
    end
  end
end