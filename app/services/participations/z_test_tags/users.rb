module Participations::ZTestTags
  class Users < ApplicationService
    Z_VALUE_LIMIT = 2

    param :user
    param :tag

    option :participated_events, default: -> { user.participated_events }

    def call
      return if rate == 0 || rate == 1
      return if se_rate == 0
      return if z_value <= Z_VALUE_LIMIT

      user.tags << tag
      user.save!
    end

    private

    def rate
      @rate ||= Event.where('tags @> ARRAY[?]::varchar[]', tag).count / Event.count.to_f
    end

    def participated_events_with_tag
      @participated_events_with_tag ||= participated_events.select { |p| p.tags.include?(tag) }
    end

    def se_rate
      @se_rate ||= rate * (1 - rate) * participated_events.count**0.5
    end

    def z_value
      @z_value ||= (participated_events_with_tag.count - rate * participated_events.count) / se_rate
    end
  end
end
