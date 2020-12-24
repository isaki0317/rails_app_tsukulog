class EndUser::BlocksController < ApplicationController
  before_action :authenticate_end_user!

  def create
    # 処理をまとめて１つの大きな処理とする、データの不整合を無くす(乱用しない)
    ActiveRecord::Base.transaction do
      block = current_end_user.active_blocks.build(blocked_id: params[:end_user_id])
      block.save!
      @end_user = EndUser.find(params[:end_user_id])
      if current_end_user.follower_by?(@end_user)
        current_end_user.destry_follow(@end_user)
      end
      current_end_user.user_room_delete(current_end_user, @end_user)
      current_end_user.notification_delete(current_end_user, @end_user)
      # logger.debug current_end_user.user_room_delete(current_end_user, @end_user).errors.inspect
    end
    redirect_to end_user_path(current_end_user.id)
  rescue => e
    # エラーメッセージを入れる
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
