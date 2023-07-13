module Api
  module V1
    class FollowsController < ApplicationController
      def create
        FollowService.new.create(follow_params, current_user)
        render json: { message: true }
      end

      def destroy
        FollowService.new.destroy(params[:id], current_user)
        render json: { message: true }
      end

      private

      def follow_params
        params.require(:follow).permit(%i[followed_user_id])
      end
    end
  end
end
