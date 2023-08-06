module Api
  module V1
    class UserController < ApplicationController
      # skip_before_action :authenticate_user!, only: %i[index]
      def index
        render json: current_user.present?
      end
    end
  end
end
