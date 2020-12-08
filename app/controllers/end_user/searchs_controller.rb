class EndUser::SearchsController < ApplicationController

  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    if @model == 'end_user'
      @data = EndUser.search_for(@value, @how)
    elsif @model == 'post'
      @data = Post.search_for(@value, @how)
    end
    @genres = Genre.all
    @comment_new = Comment.new
  end

end
