module Api
  module V1
    class CommentsController < ApplicationController
      def create
        comment = CommentService.new(current_user, comment_params).create
        render json: comment, serializer: CommentSerializer
      end

      def update
        comment = CommentService.new(current_user, comment_params, params[:id]).update
        render json: comment, serializer: CommentSerializer
      end

      def destroy
        comment = CommentService.new(current_user, {}, params[:id]).destroy
        render json: comment, serializer: CommentSerializer
      end

      private

      def comment_params
        params.require(:comment).permit(%i[body commentable_type commentable_id])
      end
    end
  end
end
