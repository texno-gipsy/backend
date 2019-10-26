class ApplicationController < ActionController::API
  def hc
    head :ok
  end

  private

  def current_user
    return unless request.headers['User-Id']

    @current_user ||= User.find(request.headers['User-Id'])
  end
end
