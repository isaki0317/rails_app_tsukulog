FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:10) }
    subtitle { Faker::Loren.characters(unmber:16) }
    # images { [ Rack::Test::UploadedFile.new(Rails.root.join('spec/factories/test.jpg'), 'spec/factories/test.jpg') ] }
    genre
    end_user
    association :material
    association :work
  end
end