class CommentsController < ApplicationController
  # load_and_authorize_resource

  def new
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to user_post_path(@post.author_id, @post)
    else
      flash.now[:error] = 'Error: Comment could not be saved'
      render :new
    end
  end

  def destoy
    @comment = Comment.find(params[:post_id])
    @post = @comment.post
    @comment.destroy
    redirect_to user_post_path(@post.author_id, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
