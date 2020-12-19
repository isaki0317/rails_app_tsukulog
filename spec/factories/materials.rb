FactoryBot.define do
  factory :material do
    material_name { Facker::Loren.characters(number:8) }
    material_shop { Facker::Loren.characters(number:8) }
    post
  end
end