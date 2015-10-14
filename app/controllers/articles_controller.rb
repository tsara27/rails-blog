class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
      @articles = Article.paginate(page: params[:page], per_page: 10).order("created_at desc")

      respond_to do |format|
        format.html { @articles }
        format.json { render json: @articles }
      end
  end

  def new
      @article = current_user.articles.build
  end

  def edit
      @article = Article.find_by_slug(params[:id])
  end

  def update
      @article = Article.find_by_slug(params[:id])

      if @article.update(article_params)
          redirect_to @article
      else
          render 'edit'
      end
  end

  def create
      @article = current_user.articles.build(article_params)
      @article.slug = "#{to_slug(params[:article][:title])}-#{randomString(6)}"

      if @article.save
          redirect_to @article
      else
          render 'new'
      end
  end

  def show
      @article = Article.find_by_slug(params[:id])
      @comments = Comment.where(article_id: @article.id).all
  end

  def destroy
      @article = Article.find_by_slug(params[:id])
      @article.destroy

      redirect_to articles_path
  end

  private
      def article_params
          params.require(:article).permit(:title,:content)
      end
end
