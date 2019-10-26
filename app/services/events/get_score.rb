module Events
  class GetScore < ApplicationService
    param :event
    param :user

    option :participants_tags, default: -> { event.participants.flat_map(&:tags) }
    option :events_count, default: -> { Event.count.to_f }
    option :user_tags, default: -> { user.tags }

    def call
      user_tags.sum(&method(:tag_score))
    end

    private

    def tag_score(tag)
      tag_count = participants_tags.select { |pt| pt == tag }.size
      time_freq = tag_count / participants_tags.count.to_f
      events_with_tag_count = events_with_tag_count(tag)
      return 0.0 if events_with_tag_count.zero?

      inverse_freq = events_count / events_with_tag_count
      log_inverse_freq = Math.log(inverse_freq, 10)
      log_inverse_freq * time_freq
    end

    def events_with_tag_count(tag)
      Event
        .distinct
        .joins(<<-SQL)
          JOIN participations
          ON participations.event_id = events.id
          JOIN users
          ON users.id = participations.user_id
          AND users.tags @> ARRAY['#{tag}']::varchar[]
        SQL
        .count
    end
  end
end
