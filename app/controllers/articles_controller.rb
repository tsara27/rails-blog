class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
      @articles = Article.paginate(page: params[:page], per_page: 10).order("created_at desc")
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

      def to_slug(title)
        #strip the string
        ret = title.strip

        #blow away apostrophes
        ret.gsub! /['`]/,""

        # @ --> at, and & --> and
        ret.gsub! /\s*@\s*/, " at "
        ret.gsub! /\s*&\s*/, " and "

        #replace all non alphanumeric, underscore or periods with underscore
         ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'

         #convert double underscores to single
         ret.gsub! /_+/,"-"

         #strip off leading/trailing underscore
         ret.gsub! /\A[_\.]+|[_\.]+\z/,""

         ret
      end

      def randomString(far)
        (0..far.to_i).map { ("a".."z").to_a[rand(26)] }.join
      end
end
