class EndUser::ContactsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @contact_new = Contact.new(contact_params)
    @contact_new.save
  end

  private
  def contact_params
    params.require(:contact).permit(:end_user_id, :title, :body)
  end

end
