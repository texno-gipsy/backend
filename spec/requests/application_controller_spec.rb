require 'rails_helper'

describe ApplicationController do
  context '#hc' do
    subject { get '/hc' }

    it 'returns 200' do
      subject
      expect(response).to have_http_status(200)
    end
  end
end
