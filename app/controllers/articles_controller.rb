class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @last_articles = Article.order(created_at: :desc).limit(6)
    @free_articles = Article.free
    @premium_articles = Article.paid
  end

  def show
    @last_articles = Article.paid.order(created_at: :desc).limit(3)
    @article = policy_scope(Article).find(params[:id])
  end

  def edit
  end

  def update
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article was successfully created."
      redirect_to @article
    else
      flash[:error] = "Error creating article."
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :price, :private)
  end
end
