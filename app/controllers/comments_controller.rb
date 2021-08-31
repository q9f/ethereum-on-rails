class CommentsController < ApplicationController
  def show
    @article = Article.find(params[:article_id])
    redirect_to article_path(@article)
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def spam
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.update(status: 'spam')
    redirect_to article_path(@article)
  end


  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
