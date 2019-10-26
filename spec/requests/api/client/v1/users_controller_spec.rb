require 'rails_helper'

describe Api::Client::V1::UsersController do
  context '#index' do
    subject { get '/api/client/v1/users' }

    let!(:user) { create(:user) }

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
            instagram: user.instagram
          }
        ].as_json
      )
    end
  end
end
