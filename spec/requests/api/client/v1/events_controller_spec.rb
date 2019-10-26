require 'rails_helper'

describe Api::Client::V1::EventsController do
  let!(:creator) { create(:user) }
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'user_id' => creator.id
    }
  end

  context '#index' do
    subject { get '/api/client/v1/events', headers: headers, params: params }

    let(:event) { create(:event) }
    let(:participant) { create(:user) }
    let(:params) { {} }

    before { create(:participation, event: event, user: participant) }

    it 'returns 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'returns json' do
      subject
      expect(json_data).to eq(
        [
          {
            id: event.id,
            title: event.title,
            description: event.description,
            creator_id: event.creator_id,
            lon: event.lon,
            lat: event.lat,
            radius: event.radius,
            tags: event.tags,
            start_at: event.start_at.utc.to_formatted_s(:iso8601),
            end_at: event.end_at.utc.to_formatted_s(:iso8601),
            duration: event.duration,
            limit: event.limit,
            participants_ids: event.participants.map(&:id).sort,
            type: 'event'
          }
        ].as_json
      )
    end

    context 'with places' do
      let(:params) do
        {
          lat: 55.751244,
          lon: 37.618423
        }
      end
      let(:response_body) do
        file_fixture('json/here_we_are/places.json').read
      end

      before do
        stub_request(:get, /here.com/).to_return(status: 200, body: response_body, headers: {})
      end

      it 'returns json' do
        subject
        expect(json_data.last).to eq(
          {
            id: -20,
            title: 'Voskhod',
            description: nil,
            creator_id: nil,
            lon: 37.627329,
            lat: 55.750317,
            radius: nil,
            tags: %w[restaurant europeancuisine russiancuisine seafoodcuisine],
            start_at: nil,
            end_at: nil,
            duration: nil,
            limit: nil,
            participants_ids: [],
            type: 'place'
          }.as_json
        )
      end
    end
  end

  context '#create' do
    subject { post '/api/client/v1/events', headers: headers, params: params.to_json }

    let(:params) do
      {
        title: Faker::Lorem.word,
        description: Faker::Lorem.sentence,
        lat: 55.751244,
        lon: 37.618423,
        radius: 5,
        tags: %w[music movie],
        start_at: '2019-01-01'.to_time.utc.to_formatted_s(:iso8601),
        end_at: '2020-01-01'.to_time.utc.to_formatted_s(:iso8601),
        duration: 5,
        limit: 10
      }
    end
    let(:created_event) { Event.last }

    it 'returns 201' do
      subject
      expect(response).to have_http_status(201)
    end
    it 'creates Event' do
      subject
      expectation = {
        id: created_event.id,
        title: params[:title],
        description: params[:description],
        creator_id: creator.id,
        lon: params[:lon],
        lat: params[:lat],
        radius: params[:radius],
        tags: params[:tags],
        start_at: params[:start_at].to_time,
        end_at: params[:end_at].to_time,
        duration: params[:duration],
        limit: params[:limit]
      }
      expect(created_event).to have_attributes(expectation)
    end
    it 'returns json' do
      subject
      expect(json_data).to eq(
        {
          id: created_event.id,
          title: created_event.title,
          description: created_event.description,
          creator_id: created_event.creator_id,
          lon: created_event.lon,
          lat: created_event.lat,
          radius: created_event.radius,
          tags: created_event.tags,
          start_at: created_event.start_at.utc.to_formatted_s(:iso8601),
          end_at: created_event.end_at.utc.to_formatted_s(:iso8601),
          duration: created_event.duration,
          limit: created_event.limit,
          participants_ids: created_event.participants.map(&:id).sort,
          type: 'event'
        }.as_json
      )
    end
  end

  context '#update' do
    subject { patch "/api/client/v1/events/#{event.id}", params: params.to_json, headers: headers }

    let!(:event) { create(:event) }
    let(:params) do
      {
        title: Faker::Lorem.word
      }
    end

    it 'returns 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'returns json' do
      subject
      expect(json_data['title']).to eq(params[:title])
    end
  end

  context '#destroy' do
    subject { delete "/api/client/v1/events/#{event.id}", headers: headers }

    let!(:event) { create(:event) }

    it 'returns 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'sets is_deleted' do
      expect { subject }.to change { event.reload.is_deleted }.from(false).to(true)
    end
  end
end
