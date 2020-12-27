class EndUser::SearchsController < ApplicationController
  before_action :authenticate_end_user!

  def search
    @model = params["search_model"]
    @value = params["search_value"]
    @how = params["search_how"]
    @order = params["order"]
    @terms = params["terms"]
    if @model == 'end_user'
      end_users = EndUser.search_for(@value, @how, @order, @terms)
      data = Post.block_action(end_users, current_end_user)
      @data = Kaminari.paginate_array(data).page(params[:page]).per(15)
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

  #楽天API商品検索
  def index
    if params[:keyword]
      items = SearchForm.new(keyword: params[:keyword])
      if items.valid?
        @items = RakutenWebService::Ichiba::Item.search(keyword: items.keyword)
      else
        flash[:danger] = "検索ワードは日本語2文字以上で入力してください(数字NG)"
        redirect_to rakuten_search_path
      end
    end
  end
end
