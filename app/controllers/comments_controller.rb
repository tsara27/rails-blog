class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:comment][:id])
    @comment = @article.comments.new

    @comment.user_id = current_user.id
    @comment.content = params[:comment][:content]
    if @comment.save
      respond_to do |format|
        format.html { redirect_to article_path(@article) }
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end
end
