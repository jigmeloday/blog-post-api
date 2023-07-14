# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index show]

      def index
        render json: Article.all, each_serializer: ArticleSerializer
      end

      def show
        article_ser = ArticleService.new(current_user, {}, article).show
        render json: article_ser, serializer: ArticleSerializer, current_user: current_user
      end

      def create
        article_ser = ArticleService.new(current_user, create_params).create
        render json: article_ser, serializer: ArticleSerializer
      end

      def destroy
        authorize article
        article_ser = ArticleService.new(current_user, {}, article).destroy
        render json: article_ser, serializer: ArticleSerializer
      end

      def update
        authorize article
        article_ser = ArticleService.new(current_user, update_params, article).update
        render json: article_ser, serializer: ArticleSerializer
      end

      private

      def id
        @id ||= params[:id]
      end

      def article
        @article ||= Article.find(id)
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
