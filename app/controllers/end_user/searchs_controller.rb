class EndUser::SearchsController < ApplicationController

  def search
    @model = params["search_model"]
    @value = params["search_value"]
    @how = params["search_how"]
    @order = params["order"]
    @terms = params["terms"]
    if @model == 'end_user'
      data = EndUser.search_for(@value, @how)
      # viewに無限スクロール実装する
      @data = data.page(params[:page]).per(10)
    elsif @model == 'post'
      data = Post.search_for(@value, @how, @order, @terms)
      public_posts = Post.block_posts(data, current_end_user)
      @data = Kaminari.paginate_array(public_posts).page(params[:page]).per(3)
    else
      data = []
      current_end_user.followings.each do |end_user|
        posts = Post.where(end_user_id: end_user.id, post_status: true)
        data.concat(posts)
      end
      @data = Kaminari.paginate_array(data).page(params[:page]).per(3)
    end
    @genres = Genre.all
    @comment_new = Comment.new
  end

end
