FactoryBot.define do
  # 実際は.envなどで隠す？
  factory :admin do
    email { 'a@a' }
    password { 'aaaaaa' }
  end
end