#encoding: utf-8
class CtpowerMailer < ActionMailer::Base
  
  default from: "city power <no-reply@citypower.com.tw>"
  
  # send to user
  def contact_notice(contact)

    attachments.inline['logo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      @contact = contact
      
      mail(:to => [ 'adam@summers.com.tw, chris@summers.com.tw' ], :subject => "通知")
    end
  end

  private

  def with_logo_image
    File.read(File.join("public","images", "logo.png")) # inline img
  end

end
