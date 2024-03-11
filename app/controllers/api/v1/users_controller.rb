module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index authenticated]

      def index
        render json: User.all.order!(follower_count: :desc).limit(3), each_serializer: UserSerializer
      end

      def profile
        render json: current_user, serializer: UserSerializer
      end

      def authenticated
        render json: current_user.present?
      end
    end
  end
end
