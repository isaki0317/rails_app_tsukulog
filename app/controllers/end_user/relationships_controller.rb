class EndUser::RelationshipsController < ApplicationController
  skip_before_action :get_current_chat_room

  def create
    @end_user = EndUser.find(params[:end_user_id])
    @user = current_end_user
    follow = current_end_user.active_relationships.build(follower_id: params[:end_user_id])
    follow.save
    @mutual_follows = current_end_user.matchers
    @followers = current_end_user.followers.where.not(id: current_end_user.followings)
  end

  def destroy
    @end_user = EndUser.find(params[:end_user_id])
    @user = current_end_user
    follow = current_end_user.active_relationships.find_by(follower_id: params[:end_user_id])
    follow.destroy
    @mutual_follows = current_end_user.matchers
    @followers = current_end_user.followers.where.not(id: current_end_user.followings)
  end

end
