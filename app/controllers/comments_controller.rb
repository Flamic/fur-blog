class CommentsController < ApplicationController
    def create
      redirect_if_unauthorized
      @article = Article.find(params[:article_id])
      @comment = Comment.create(comment_params)
      @comment.article = @article
      @comment.user = current_user
      @comment.save
      redirect_to article_path(@article)
    end
    
    def destroy
      redirect_if_unauthorized
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      redirect_to article_path(@article)
    end

    private
      def comment_params
        params.require(:comment).permit(:body)
      end

      def redirect_if_unauthorized
        if !user_signed_in?
          redirect_to new_user_registration_path
        end
      end
end