module Participations::ZTestTags
  class Events < ApplicationService
    Z_VALUE_LIMIT = 2

    param :event
    param :tag

    option :participants, default: -> { event.participants }

    def call
      return if rate == 0 || rate == 1
      return if se_rate == 0
      return if z_value <= Z_VALUE_LIMIT

      event.tags << tag
      event.save!
    end

    private

    def rate
      @rate ||= User.where('tags @> ARRAY[?]::varchar[]', tag).count / User.count.to_f
    end

    def participants_with_tag
      @participants_with_tag ||= participants.select { |p| p.tags.include?(tag) }
    end

    def se_rate
      @se_rate ||= rate * (1 - rate) * participants.count**0.5
    end

    def z_value
      @z_value ||= (participants_with_tag.count - rate * participants.count) / se_rate
    end
  end
end
