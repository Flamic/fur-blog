class ArticlesController < ApplicationController
  def index
    @search_text = (params.has_key?(:title) ? params[:title] : '')
    @category_id = (params.has_key?(:category_id) ? params[:category_id] : '0')
    @category = (@category_id == '0' ? 'All' : Category.find(@category_id).name)
    @articles = Article.status_or_user_is("public", current_user)

    if !@search_text.empty?
      @articles = @articles.starts_with(params[:title])
    end
    if @category_id != '0'
      @articles = @articles.category_is(@category_id)
    end
    
    @articles = @articles.order(:created_at).page params[:page]
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    redirect_if_unauthorized
    @article = Article.new
  end

  def create
    redirect_if_unauthorized
    @article = Article.new(article_params)
    @article.user = current_user

    @article.attachment = Attachment.create(article_id: @article.id,
      data: params[:attachment][:data].read,
      filename: params[:attachment][:data].original_filename,
      mime_type: params[:attachment][:data].content_type)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    redirect_if_unauthorized

    @article = Article.find(params[:id])
  end

  def update
    redirect_if_unauthorized
    @article = Article.find(params[:id])
    if @article.user != current_user
      redirect_to root_path
    end

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    redirect_if_unauthorized
    @article = Article.find(params[:id])
    if @article.user != current_user
      redirect_to root_path
    end
    @article.destroy

    redirect_to root_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :category_id, :attachment_id)
    end

    def redirect_if_unauthorized
      if !user_signed_in?
        redirect_to new_user_registration_path
      end
    end
end
