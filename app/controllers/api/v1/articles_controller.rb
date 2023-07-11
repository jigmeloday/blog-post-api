# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index show]

      def index
        render json: Article.all, each_serializer: ArticleSerializer
      end

      def show
        article = ArticleService.new.show(params[:id])
        render json: article, serializer: ArticleSerializer
      end

      def create
        article = ArticleService.new.create(create_params)
        render json: article, serializer: ArticleSerializer
      end

      def destroy
        article = ArticleService.new.destroy(params[:id])
        render json: article, serializer: ArticleSerializer
      end

      def update
        article = ArticleService.new.update(params[:id], update_params)
        render json: article, serializer: ArticleSerializer
      end

      private

      def create_params
        params.require(:article).permit(
          %i[
            title body user_id
          ]
        )
      end

      def update_params
        params.require(:article).permit(
          %i[
            id title body user_id
          ]
        )
      end
    end
  end
end
