FactoryBot.define do
  factory :event do
    creator { create(:user) }
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    lat { 55.751244 }
    lon { 37.6 }
    radius { 2 }
    tags { %w[music movie] }
    start_at { 1.day.ago }
    end_at { 2.days.from_now }
    duration { 2 }
    limit { 2 }
  end
end
