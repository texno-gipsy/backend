module Api::Client::V1
  class UsersPage < ApplicationPage
    param :users

    section :data

    def data
      users.map { |u| UserPage.new(u).to_h }
    end
  end
end
