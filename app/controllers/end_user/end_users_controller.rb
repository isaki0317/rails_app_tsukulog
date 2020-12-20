class EndUser::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :correct_end_user, only: [:edit]

  def show
    @end_user = EndUser.find(params[:id])
    @public_posts = @end_user.posts.where(post_status: "true")
    @draft_posts = @end_user.posts.where(post_status: "false")
    @bookmarks = @end_user.bookmarks
    @mutual_follows = @end_user.matchers
    followers = current_end_user.followers.where.not(id: current_end_user.followings)
    @followers = Post.block_action(followers, current_end_user)
    @contact_new = Contact.new
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

  def correct_end_user
    end_user = EndUser.find(params[:id])
    unless end_user.id == current_end_user.id
      redirect_to posts_path
    end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :images, :address, :experience, :sex, :date_of_birth)
  end

end
