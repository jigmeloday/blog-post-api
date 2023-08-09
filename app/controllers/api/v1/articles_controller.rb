# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index show popular]

      def index
        render json: Article.all.order!(created_at: :desc), each_serializer: ArticleSerializer
      end

      def show
        article = ArticleService.new(current_user, {}, id).show
        render json: article, serializer: ArticleSerializer, current_user: current_user
      end

      def create
        article = ArticleService.new(current_user, create_params).create
        render json: article, serializer: ArticleSerializer
      end

      def destroy
        article = ArticleService.new(current_user, {}, id).destroy
        render json: article, serializer: ArticleSerializer
      end

      def update
        article = ArticleService.new(current_user, update_params, id).update
        render json: article, serializer: ArticleSerializer
      end

      def popular
        render json: Article.order(like_count: :desc).limit(3)
      end

      private

      def id
        @id ||= params[:id]
      end

      def create_params
        params.require(:article).permit(
          %i[
            title body
          ]
        )
      end

      def update_params
        params.require(:article).permit(
          %i[
            id title body
          ]
        )
      end
    end
  end
end
