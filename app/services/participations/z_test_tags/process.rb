module Participations::ZTestTags
  class Process < ApplicationService
    param :participation

    option :event, default: -> { participation.event }
    option :user, default: -> { participation.user }
    option :participants, default: -> { event.participants }

    def call
      user.tags.each do |tag|
        next if event.tags.include?(tag)

        Participations::ZTestTags::Events.call(event, tag)
      end
      event.tags.each do |tag|
        next if user.tags.include?(tag)

        Participations::ZTestTags::Users.call(user, tag)
      end
    end
  end
end
