class EndUser::HomesController < ApplicationController
  before_action :correct_home

  def top
  end

  # sign_in時のみtopへのurl直打ち移動を禁止
  def correct_home
    if end_user_signed_in?
      redirect_to posts_path
    elsif admin_signed_in?
      redirect_to admin_end_users_path
    end
  end

end
