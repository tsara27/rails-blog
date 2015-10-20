class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]
  before_action :fetch_article, except: [:index, :new, :create]

  def index
    if params[:tag]
      @articles = Article.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 10)
    elsif current_user
      @articles = current_user.feed.paginate(page: params[:page], per_page: 10).order("created_at desc")
    else
      @articles = Article.paginate(page: params[:page], per_page: 10).order("created_at desc")
    end

    respond_to do |format|
      format.html { @articles }
      format.json { render json: @articles }
    end
  end

  def new
    @article = current_user.articles.build
  end

  def edit; end

  def update
    @article.save

    respond_to do |format|
      if @article.update(article_params)
        @saved = true
        format.html { redirect_to @article }
        format.js
        format.json { @article }
      else
        @saved = false
        format.html { redirect_to 'new' }
        format.js
        format.json { @article }
      end
    end
  end

  def create
    @article = current_user.articles.build(article_params)
    @article.slug = "#{to_slug(params[:article][:title])}-#{randomString(6)}"
    @article.anon = params[:anon]

    respond_to do |format|
      if @article.save
        @saved = true
        format.html { redirect_to @article }
        format.js
        format.json { @article }
      else
        @saved = false
        format.html { redirect_to 'new' }
        format.js
        format.json { @article }
      end
    end
  end

  def show
    @comments = Comment.where(article_id: @article.id)
    # all is not required after using where
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end

  private
  
  # Don't have to add indentation to show private method. You can only add one empty line
  # https://github.com/bbatsov/ruby-style-guide#consistent-classes
  def article_params
    published = params[:publish] ? 1 : 0
    params.require(:article).permit(:title, :content, :topic_list).merge(published: published)
    # Add space between each attributes. 
  end
  
  def fetch_article
    @article = Article.find_by_slug(params[:id])
  end
end
