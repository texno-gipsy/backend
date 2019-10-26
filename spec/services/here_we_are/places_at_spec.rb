require 'rails_helper'

describe HereWeAre::PlacesAt do
  subject { described_class.call(lat, lon) }

  let(:lat) { 55.751244 }
  let(:lon) { 37.618423 }
  let(:response_body) do
    file_fixture('json/here_we_are/places.json').read
  end

  before do
    stub_request(:get, /here.com/).to_return(status: 200, body: response_body, headers: {})
  end

  it 'returns hash' do
    expect(subject).to eq(JSON.parse(response_body).deep_symbolize_keys)
  end
end
