#encoding: utf-8
class ContactsController < ApplicationController
  #new business contact
  def index
    set_options
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
          # @contact = Contact.new
          set_options
          flash.now[:notice] = @reservation.errors.full_messages
          format.html { render :index }
        end
      end
    
    else
      @contact = Contact.new
      set_options
      flash.now[:alert] = "驗證碼錯誤"
      flash.delete :recaptcha_error
      render :index
    end

  end
  # subject 單選選項
  # 與我們合作頁選項(單選)
  # BES加盟系統、經銷代銷
  private

  def set_options
    @options = [["bes","BES加盟系統"],["coop","經銷代銷"]]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params  
    params.require(:contact).permit(:subject , :name, :email, :phone, :content)
  end
end