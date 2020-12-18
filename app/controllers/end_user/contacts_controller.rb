class EndUser::ContactsController < ApplicationController

  def create
    @contact_new = Contact.new(contact_params)
    if @contact_new.save
      redirect_to end_user_path(current_end_user.id)
    else
      @end_user = current_end_user
      @public_posts = current_end_user.posts.where(post_status: "true")
      @draft_posts = current_end_user.posts.where(post_status: "false")
      @bookmarks = current_end_user.bookmarks
      @mutual_follows = current_end_user.matchers
      followers = current_end_user.followers.where.not(id: current_end_user.followings)
      @followers = Post.block_action(followers, current_end_user)
      render 'end_user/end_users/show'
    end
  end

  private
  def contact_params
    params.permit(:end_user_id, :title, :body)
  end

end
