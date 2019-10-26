module Api::Client::V1
  class EventsPage < Tram::Page
    param :events

    section :data

    def data
      events.map { |e| EventPage.new(e).to_h }
    end
  end
end
