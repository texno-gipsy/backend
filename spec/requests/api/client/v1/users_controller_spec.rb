require 'rails_helper'

describe Api::Client::V1::UsersController do
  let!(:user) { create(:user) }

  context '#index' do
    subject { get '/api/client/v1/users' }

    it 'returns 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'returns json' do
      subject
      expect(json_data).to eq(
        [
          {
            id: user.id,
            name: user.name,
            instagram: user.instagram,
            tags: user.tags
          }
        ].as_json
      )
    end
  end

  context '#show' do
    subject { get "/api/client/v1/users/#{user.id}" }

    it 'returns 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'returns json' do
      subject
      expect(json_data).to eq(
        {
          id: user.id,
          name: user.name,
          instagram: user.instagram,
          tags: user.tags
        }.as_json
      )
    end
  end

  context '#update' do
    subject { patch "/api/client/v1/users/#{user.id}", params: params }

    let(:params) do
      { tags: Faker::Lorem.words }
    end

    it 'returns 200' do
      subject
      expect(response).to have_http_status(200)
    end
    it 'returns json' do
      subject
      expect(json_data).to eq(
        {
          id: user.id,
          name: user.name,
          instagram: user.instagram,
          tags: params[:tags]
        }.as_json
      )
    end
  end
end
