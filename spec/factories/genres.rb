FactoryBot.define do
  factory :genre do
    name { Facker::Loren.characters(number:8) }
  end
end