module Api::Client::V1
  class EventsController < ApplicationController
    def create
      event = Event.create!(permitted_params.merge(creator: current_user))
      Participation.create!(event: event, user: current_user)
      render json: { data: EventPage.new(event, user: current_user).to_h }, status: :created
    end

    def update
      event.update!(permitted_params)
      render json: { data: EventPage.new(event, user: current_user).to_h }, status: :ok
    end

    def index
      events = Event.where(is_deleted: false)
      render json: EventsPage.new(events, user: current_user, params: params).to_h, status: :ok
    end

    def show
      render json: { data: EventPage.new(event, user: current_user).to_h }, status: :ok
    end

    def destroy
      event.update!(is_deleted: true)
      head :ok
    end

    private

    def event
      @event ||= Event.find(params[:id])
    end

    def permitted_params
      params.permit(
        :title,
        :description,
        :creator_id,
        :lon,
        :lat,
        :radius,
        :start_at,
        :end_at,
        :duration,
        :limit,
        tags: []
      )
    end
  end
end
