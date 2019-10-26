class User < ApplicationRecord
  has_many :participations
  has_many :participated_events, class_name: 'Event', through: :participations, source: :event
end
