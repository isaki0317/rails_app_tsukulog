class Admin::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @favorites = @post.favorites
    @bookmarks = @post.bookmarks
    @comments = @post.comments
  end

  def destroy
  end

  def edit
  end

end
