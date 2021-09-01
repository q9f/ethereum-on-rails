class CommentsController < ApplicationController

  # this is not an actual secret ;)
  # @TODO: @q9f replace with omniauth/omniauth
  http_basic_authenticate_with name: "bob", password: "alice1993", only: [:spam, :destroy]

  # generic redirect to article of comment with :article_id parent
  def show
    @article = Article.find(params[:article_id])
    redirect_to article_path(@article)
  end

  # create comment for parent :article_id
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  # mark comment with :id as spam
  def spam
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.update(status: 'spam')
    redirect_to article_path(@article)
  end

  # delete comment with :id
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  # sanity checks on comment params
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
