module Api
  module V1
    class FollowsController < ApplicationController
      def create
        FollowService.new(current_user, follow_params).create
        render json: { message: true }
      end

      def destroy
        FollowService.new(current_user, params).destroy
        render json: { message: true }
      end

      private

      def follow_params
        params.require(:follow).permit(%i[followed_user_id])
      end
    end
  end
end
