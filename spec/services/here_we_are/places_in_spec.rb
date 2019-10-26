require 'rails_helper'

describe HereWeAre::PlacesIn do
  subject { described_class.call(top, bottom) }

  let(:top) do
    {
      lat: 55.9059,
      lon: 37.7926
    }
  end
  let(:bottom) do
    {
      lat: 55.5999,
      lon: 37.3257
    }
  end
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
