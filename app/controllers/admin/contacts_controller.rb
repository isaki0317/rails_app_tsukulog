class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @contacts = Contact.order("checked")
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update(contact_params)
    redirect_to admin_contacts_path
  end

  private

  def contact_params
    params.require(:contact).permit(:end_user_id, :title, :body, :checked)
  end
end
