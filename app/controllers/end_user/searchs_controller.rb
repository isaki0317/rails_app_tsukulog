class EndUser::SearchsController < ApplicationController

  def search
    @model = params["search_model"]
    @value = params["search_value"]
    @how = params["search_how"]
    @order = params["order"]
    @terms = params["terms"]
    if @model == 'end_user'
      data = EndUser.search_for(@value, @how)
      @data = data.page(params[:page]).per(2)
    else
      data = Post.search_for(@value, @how, @order, @terms)
      @data = data.page(params[:page]).per(2)
    end
    @genres = Genre.all
    @comment_new = Comment.new
  end

end
