module Helpers
  def json_data
    JSON.parse(response.body)['data']
  end
end
