class EndUser::ContactsController < ApplicationController

  def create
    @contact_new = Contact.new(contact_params)
    @contact_new.save
    redirect_to end_user_path(current_end_user.id)
  end

  private
  def contact_params
    params.permit(:end_user_id, :title, :body)
  end

end
