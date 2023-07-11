# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      def create
        like = LikeService.new.create!(params)
        render json: like, serializer: LikeSerializer
      end

      private

      def create_params
        params.require(params).permit(%i[user_id likeable likeable_id])
      end
    end
  end
end
