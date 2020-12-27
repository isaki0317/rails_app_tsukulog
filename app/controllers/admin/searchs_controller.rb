class Admin::SearchsController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params["search_model"]
    @value = params["search_value"]
    @how = params["search_how"]
    if @model == 'end_user'
      @data = EndUser.search_for(@value, @how, 'admin', 'admin')
    else
      @data = Post.search_for(@value, @how, nil, nil)
    end
  end
end
