module Api
  module V1
    class ArticlesController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index show]

      def create
        article = ArticleService.new.create(create_params)
        render json: article, serializer: ArticleSerializer
      end

      private

      def create_params
        params.require(:article).permit(
          [
            :title, :body, :user_id
          ]
        )
      end
    end
  end
end