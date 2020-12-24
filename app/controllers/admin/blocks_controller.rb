class Admin::BlocksController < ApplicationController
  before_action :authenticate_admin!

  def index
    @end_user = EndUser.find(params[:end_user_id])
    @user_blocks = @end_user.blockers
  end
end
