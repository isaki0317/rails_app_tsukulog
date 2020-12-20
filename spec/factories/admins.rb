FactoryBot.define do
  factory :admin do
    email { Facker::Internet.email }
    password { 'password' }
  end
end