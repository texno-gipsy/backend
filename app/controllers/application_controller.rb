class ApplicationController < ActionController::API
  def hc
    head :ok
  end

  private

  def current_user
    @current_user ||= User.find(request.headers['user_id'])
  end
end
