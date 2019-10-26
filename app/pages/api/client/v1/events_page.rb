module Api::Client::V1
  class EventsPage < ApplicationPage
    param :events

    option :user, optional: true
    option :params, default: -> { {} }
    option :lat, default: -> { params[:lat] }
    option :lon, default: -> { params[:lon] }

    section :data

    def data
      events.map { |e| EventPage.new(e, user: user).to_h } +
        places.map.with_index { |place, i| place_to_event_page(place, i).to_h }
    end

    private

    def places
      return [] unless lat && lon

      HereWeAre::PlacesAt.call(lat, lon).dig(:results, :items) || []
    end

    def place_to_event_page(place, index)
      lat, lon = place[:position]
      tags = []
      tags << place.dig(:category, :id)
      tags += (place[:tags] || []).map { |tag| (tag[:id] + tag[:group]).delete('-') }
      tags = tags.compact.uniq
      event = Event.new(
        id: -index - 1,
        title: place[:title],
        lat: lat,
        lon: lon,
        tags: tags
      )
      EventPage.new(event, place: true)
    end
  end
end
