class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :participations
  has_many :participants, through: :participations, source: :user
end
