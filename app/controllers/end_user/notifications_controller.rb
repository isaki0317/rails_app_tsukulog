class EndUser::NotificationsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    notifications = current_end_user.passive_notifications.page(params[:page]).per(15)
    notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @notifications = notifications.where.not(visitor_id: current_end_user.id)
  end

  def destroy_all
    #表示されている全ての通知を削除
    @notifications = current_end_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end

end
