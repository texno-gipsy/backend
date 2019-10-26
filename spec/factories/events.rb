FactoryBot.define do
  factory :event do
    creator { create(:user) }
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    lon { 2.5 }
    lat { 3.5 }
    radius { 2 }
    tags { %w[a b] }
    start_at { 1.day.ago }
    end_at { 2.days.from_now }
    duration { 2 }
    limit { 2 }
  end
end
