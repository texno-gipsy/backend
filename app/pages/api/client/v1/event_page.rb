module Api::Client::V1
  class EventPage < ApplicationPage
    param :event

    section :id, value: -> { event.id }
    section :title, value: -> { event.title }
    section :description, value: -> { event.description }
    section :creator_id, value: -> { event.creator_id }
    section :lon, value: -> { event.lon }
    section :lat, value: -> { event.lat }
    section :radius, value: -> { event.radius }
    section :tags, value: -> { event.tags }
    section :start_at, value: -> { event.start_at.utc.to_formatted_s(:iso8601) }
    section :end_at, value: -> { event.end_at.utc.to_formatted_s(:iso8601) }
    section :duration, value: -> { event.duration }
    section :limit, value: -> { event.limit }
    section :participants_ids, value: -> { event.participants.map(&:id).sort }
  end
end
