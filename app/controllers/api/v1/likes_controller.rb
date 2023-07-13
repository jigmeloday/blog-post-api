# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      def create
        like = LikeService.new(current_user, create_params).create
        render json: like, serializer: LikeSerializer
      end

      def destroy
        like = LikeService.new(current_user, destroy_params, params[:id]).destroy
        render json: like, serializer: LikeSerializer
      end

      private

      def create_params
        params.require(:like).permit(%i[likable_type likable_id])
      end

      def destroy_params
        params.require(:like).permit(:likable_type)
      end
    end
  end
end
