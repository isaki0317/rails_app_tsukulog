class Admin::BlocksController < ApplicationController

  def index
    @end_user = EndUser.find(params[:end_user_id])
    @user_blocks = @end_user.blockers
  end

end
