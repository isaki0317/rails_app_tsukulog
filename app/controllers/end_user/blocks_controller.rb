class EndUser::BlocksController < ApplicationController

  def create
    block = current_end_user.active_blocks.build(blocked_id: params[:end_user_id])
    block.save
    @end_user = EndUser.find(params[:end_user_id])
    if current_end_user.follower_by?(@end_user)
      current_end_user.destry_follow!(@end_user)
    end
    redirect_to end_user_path(current_end_user.id)
  end

  def destroy
    block = current_end_user.active_blocks.find_by(blocked_id: params[:end_user_id])
    block.destroy
    @user_blocks = current_end_user.blockers
  end

  def index
    # ログインユーザーがブロックしているユーザーを集める
    @user_blocks = current_end_user.blockers
  end

end
