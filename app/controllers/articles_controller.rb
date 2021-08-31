class ArticlesController < ApplicationController

  # this is not an actual secret ;)
  # @TODO: @q9f replace with omniauth/omniauth
  http_basic_authenticate_with name: "bob", password: "alice1993", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
