FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.name }
    instagram { Faker::Internet.url }
  end
end
