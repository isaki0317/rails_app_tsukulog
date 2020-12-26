class EndUser::BlocksController < ApplicationController
  before_action :authenticate_end_user!

  def create
    if current_end_user.block!(params[:end_user_id])
      redirect_to end_user_path(current_end_user.id)
    else
      # エラーメッセージを入れる
      # flash[:danger] = "予期せぬエラーが発生しました ブロックできませんでした"
      redirect_to end_user_path(current_end_user.id)
    end
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
