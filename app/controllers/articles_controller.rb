class ArticlesController < ApplicationController
  def index
    @search_text = (params.has_key?(:title) ? params[:title] : '')
    @category_id = (params.has_key?(:category_id) ? params[:category_id] : '0')
    @category = (@category_id == '0' ? 'All' : Category.find(@category_id).name)
    @articles = Article.all

    if !@search_text.empty?
      @articles = @articles.starts_with(params[:title])
    end
    if @category_id != '0'
      @articles = @articles.category_is(@category_id)
    end
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
      params.require(:article).permit(:title, :body, :status, :category_id)
    end
end
