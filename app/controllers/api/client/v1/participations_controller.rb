module Api::Client::V1
  class ParticipationsController < ApplicationController
    def create
      participation = Participation.find_or_create_by(user: current_user, event: event)
      Participations::ZTestTags::Process.call(participation)
      head :created
    end

    def destroy
      Participation.find_by(user: current_user, event: event).destroy!
      head :ok
    end

    private

    def event
      @event ||= Event.find(params[:event_id])
    end
  end
end
