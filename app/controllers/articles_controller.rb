class ArticlesController < ApplicationController

  # this is not an actual secret ;)
  # @TODO: @q9f replace with omniauth/omniauth
  http_basic_authenticate_with name: "bob", password: "alice1993", except: [:index, :show]

  # this is actually the root path
  def index
    @articles = Article.all
  end

  # single article page
  def show
    @article = Article.find(params[:id])
  end

  # create new article form route
  def new
    @article = Article.new
  end

  # create new article form submission
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  # edit existing article with :id route
  def edit
    @article = Article.find(params[:id])
  end

  # update existing article with :id form submission
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  # delete existing article with :id
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path
  end

  # sanity checks on article params
  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
