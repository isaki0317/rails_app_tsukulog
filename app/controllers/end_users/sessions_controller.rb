# frozen_string_literal: true

class EndUsers::SessionsController < Devise::SessionsController
  # before_action :reject_inactive_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def new_guest
    end_user = EndUser.guest
    # 閲覧者が退会しても良いように
    end_user.update(is_deleted: false)
    sign_in end_user
    flash[:success] = "ゲストユーザーとしてログインしました"
    redirect_to posts_path
  end

  # protected
  protected

  def reject_user
    end_user = EndUser.find_by(email: params[:user][:email].downcase)
    if end_user
      if end_user.valid_password?(params[:user][:password]) && (end_user.active_for_authentication? == true)
        redirect_to new_user_session_path
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # def reject_inactive_customer
  #   @end_user = EndUser.find_by(email: params[:end_user][:email])
  #   if @end_user
  #     if @end_user.valid_password?(params[:end_user][:password]) && !@end_user.is_deleted
  #       flash[:danger] = 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
  #       redirect_to new_end_user_registration_path
  #     end
  #   end
  # end
end
