class CommentsController < ApplicationController

  # this is not an actual secret ;)
  # @TODO: @q9f replace with omniauth/omniauth
  http_basic_authenticate_with name: "bob", password: "alice1993", only: [:spam, :destroy]

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
