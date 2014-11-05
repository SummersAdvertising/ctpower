#encoding: utf-8
class ContactsController < ApplicationController
  #new business contact
  def index
    @contact = Contact.new()
  end

  def create

    if verify_recaptcha

      @contact = Contact.create(contact_params)

      respond_to do |format|
        if @contact.save
          
          CtpowermailerJob.new.async.perform(CtpowerMailer, :contact_notice, @contact)
          
          flash[:notice] = "更新成功"
          format.html { redirect_to contacts_path() }
        else
          @contact = Contact.new
          format.html { render :index , notice: @contact.errors.full_messages }
        end
      end
    
    else
      @contact = Contact.new
      flash.now[:alert] = "驗證碼錯誤"
      flash.delete :recaptcha_error
      render :index
    end

  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params  
    params.require(:contact).permit(:subject, :name, :email, :phone, :content)
  end
end