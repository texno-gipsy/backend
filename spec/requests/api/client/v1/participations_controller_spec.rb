require 'rails_helper'

describe Api::Client::V1::ParticipationsController do
  let!(:user) { create(:user) }
  let(:event) { create(:event) }

  context '#create' do
    subject { post '/api/client/v1/participations', params: params, headers: headers }

    let(:params) do
      { event_id: event.id }
    end

    let(:headers) do
      { user_id: user.id }
    end

    it 'returns 201' do
      subject
      expect(response).to have_http_status(201)
    end
    it 'calls Participations::ZTestTags::Process' do
      expect(Participations::ZTestTags::Process).to receive(:call).and_call_original
      subject
    end
  end

  context '#destroy' do
    subject { post '/api/client/v1/participations', params: params, headers: headers }

    let(:params) do
      { event_id: event.id }
    end

    let(:headers) do
      { user_id: user.id }
    end

    it 'returns 201' do
      subject
      expect(response).to have_http_status(201)
    end
  end
end
