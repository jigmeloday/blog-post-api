module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index]

      def index
        render json: User.all.order!(follower_count: :desc), each_serializer: UserSerializer
      end
    end
  end
end
