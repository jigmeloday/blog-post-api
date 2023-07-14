# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index show]

      def index
        render json: Article.all, each_serializer: ArticleSerializer
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
        authorize(article, policy_class: ArticlePolicy)
        article = ArticleService.new(current_user, {}, id).destroy
        render json: article, serializer: ArticleSerializer
      end

      def update
        article = ArticleService.new(current_user, update_params, id).update
        render json: article, serializer: ArticleSerializer
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
