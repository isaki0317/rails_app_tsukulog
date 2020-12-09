class EndUser::PostsController < ApplicationController

  def new
    @post_new = Post.new
    @works = @post_new.works.new
    @post_new.materials.new
    @genres = Genre.all
  end

  def index
    @order = params["order"]
    @terms = params["terms"]
    public_posts = Post.sort_for(@order, @terms)
    @public_posts = public_posts.where(post_status: "true")

    @genres = Genre.all
    @comment_new = Comment.new
  end

  def show
    @genres = Genre.all
    @post = Post.find(params[:id])
    @comment_new = Comment.new
  end

  def create
    @post_new = Post.new(post_params)
    @post_new.save

    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:end_user_id, :genre_id, :title, :images, :subtitle, :cost, :creation_time, :level, :caution, :link, :post_status,
    materials_attributes: [:post_id, :material_name, :shop], works_attributes: [:post_id, :detail, :images])
  end

end
