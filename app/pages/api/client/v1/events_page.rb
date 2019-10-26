module Api::Client::V1
  class EventsPage < ApplicationPage
    param :events

    section :data

    def data
      events.map { |e| EventPage.new(e).to_h }
    end
  end
end
