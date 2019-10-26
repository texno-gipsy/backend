module Api::Client::V1
  class UsersController < ApplicationController
    def index
      users = User.all
      render json: UsersPage.new(users).to_h, status: :ok
    end
  end
end
