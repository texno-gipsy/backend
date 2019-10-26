module HereWeAre
  class PlacesIn < ApplicationService
    URL = 'https://places.demo.api.here.com/places/v1/discover/explore'.freeze

    param :top
    param :bottom
    option :category, optional: true
    option :size, default: -> { 100 }

    def call
      result = JSON.parse(response.body)
      result.deep_symbolize_keys
    end

    private

    def response
      @response ||= Curl.get(URL, params)
    end

    def params
      {
        app_id: ENV['HERE_WE_ARE_APP_ID'],
        app_code: ENV['HERE_WE_ARE_APP_CODE'],
        in: [bottom[:lon], bottom[:lat], top[:lon], top[:lat]].join(','),
        cat: category,
        size: size
      }.delete_if { |_, v| v.blank? }
    end
  end
end
