module Api::Client::V1
  class UserPage < ApplicationPage
    param :user

    section :id, value: -> { user.id }
    section :name, value: -> { user.name }
    section :instagram, value: -> { user.instagram }
    section :tags, value: -> { user.tags }
  end
end
