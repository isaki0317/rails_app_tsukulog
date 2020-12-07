class ApplicationController < ActionController::Base

  before_action :get_current_chat_room
  def get_current_chat_room
    @mutual_follow = current_end_user.matchers2
  end

end
