class Admin::SearchsController < ApplicationController

  def search
    @model = params["search_model"]
    @value = params["search_value"]
    @how = params["search_how"]
    if @model == 'end_user'
      @data = EndUser.search_for(@value, @how)
    else
      # nilを運ぶ必要があるのか
      @data = Post.search_for(@value, @how, 'admin', 'admin')
    end
  end

end
