# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      def create
        like = LikeService.new.create(create_params)
        render json: like, serializer: LikeSerializer
      end

      private

      def create_params
        binding.pry
        params.require(:like).permit(%i[user_id likable_type likable_id])
      end
    end
  end
end
