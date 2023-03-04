class LikesController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @like = @post.likes.new
  
      if @like.save
        flash[:success] = 'Post liked successfully'
        redirect_to user_post_path(@post.author_id, @post)
      else
        flash[:error] = 'Error: Post could not be liked'
      end
  
    end
end
