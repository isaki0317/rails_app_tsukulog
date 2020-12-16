class EndUser::EndUsersController < ApplicationController

  def show
    @end_user = EndUser.find(params[:id])
    @public_posts = @end_user.posts.where(post_status: "true")
    @draft_posts = @end_user.posts.where(post_status: "false")
    @bookmarks = @end_user.bookmarks
    @mutual_follows = @end_user.matchers
    followers = current_end_user.followers.where.not(id: current_end_user.followings)
    @followers = Post.block_action(followers, current_end_user)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user)
    else
      render 'edit'
    end
  end

  def out
    @end_user = EndUser.find(params[:id])
    @end_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def quit
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :images, :address, :experience, :sex, :date_of_birth)
  end

end
