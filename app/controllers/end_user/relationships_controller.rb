class EndUser::RelationshipsController < ApplicationController
  skip_before_action :get_current_chat_room

  def create
    @end_user = EndUser.find(params[:end_user_id])
    follow = current_end_user.active_relationships.build(follower_id: params[:end_user_id])
    follow.save
    if params[:user] == "current_end_user"
      @mutual_follows = @end_user.matchers
    else
      @mutual_follows = current_end_user.matchers
      @end_user = current_end_user
    end
    @followers = current_end_user.followers.where.not(id: current_end_user.followings)
    @end_user.create_notification_follow!(current_end_user, @end_user)
    # respond_to :jsだけでいけないか完成後に試す
    respond_to :js
  end

  def destroy
    @end_user = EndUser.find(params[:end_user_id])
    follow = current_end_user.active_relationships.find_by(follower_id: params[:end_user_id])
    follow.destroy
    if params[:user] == "end_user"
      @mutual_follows = @end_user.matchers
    else
      @mutual_follows = current_end_user.matchers
      @end_user = current_end_user
    end
    @followers = current_end_user.followers.where.not(id: current_end_user.followings)
  end

end


