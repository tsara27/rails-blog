class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new

    @comment.user_id = current_user.id
    @comment.content = params[:comment][:content]
    if @comment.save
      redirect_to article_path(@article)
    end
  end
end
