class ContactsController < ApplicationController
  #new business contact
  def index
    @contact = Contact.new()
  end

  def create
    
    @contact = Contact.create(contact_params)

    respond_to do |format|
      if @contact.save
       
        flash[:notice] = "更新成功"
        format.html { redirect_to contacts_path() }
        #format.js {render :js => "window.location.href=window.location.href;"}
      else
        format.html { redirect_to :back , notice: @contact.errors.full_messages }
      end
    end

  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params  
    params.require(:contact).permit(:subject, :name, :email, :phone, :content)
  end
end