# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      def create
        like = LikeService.new.create(create_params, current_user)
        render json: like, serializer: LikeSerializer
      end

      def destroy
        like = LikeService.new.destroy(params[:id])
        render json: like, serializer: LikeSerializer
      end

      private

      def create_params
        params.require(:like).permit(%i[likable_type likable_id])
      end
    end
  end
end
