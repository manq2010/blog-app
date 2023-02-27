class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @posts.each do |post|
      params[:title] = post.title
    end
  end
end
