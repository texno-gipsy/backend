module Api::Client::V1
  class UsersController < ApplicationController
    def index
      users = User.all
      render json: UsersPage.new(users).to_h, status: :ok
    end

    def update
      user.update!(permitted_params)
      render json: { data: UserPage.new(user).to_h }, status: :ok
    end

    def show
      render json: { data: UserPage.new(user).to_h }, status: :ok
    end

    private

    def user
      @user ||= User.find(params[:id])
    end

    def permitted_params
      params.permit(
        :name,
        :instagram,
        tags: []
      )
    end
  end
end
