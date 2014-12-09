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
          
          if @contact.subject.in? ["testdrive", "opinion", "etc"]
            # 預約試乘、意見回饋、其他，這三個類別要寄到bes_services@citypower.com.tw
            CtpowermailerJob.new.async.perform(CtpowerMailer, :contact_notice, @contact)    
          elsif @contact.subject.in? ["bes", "coop"]
            # BES加盟系統、經銷代銷，要寄送到service@citypower.com.tw
            CtpowermailerJob.new.async.perform(CtpowerMailer, :biz_contact_notice, @contact)    
          end

          flash[:notice] = "表單送出完成，我們將會盡快與您聯絡。"
          format.html { redirect_to contacts_path() }
        else
          # @contact = Contact.new
          set_options
          #flash.now[:notice] = @contact.errors.full_messages
          flash.now[:notice] = @contact.errors.messages.values.flatten.join('<br />')
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
  # 聯絡我們頁選項(單選)
  # 預約試乘、意見回饋、其他  BES加盟系統、經銷代銷
  private

  def set_options
    @options = [["testdrive","預約試乘"],["opinion","意見回饋"],["bes","BES加盟系統"],["coop","經銷代銷"],["etc","其他"]]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params  
    params.require(:contact).permit(:subject , :name, :email, :phone, :content)
  end
end