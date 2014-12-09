#encoding: utf-8
class CtpowerMailer < ActionMailer::Base
  
  default from: "citypower台灣城市動力<cs_service@citypower.com.tw>"
  
  # send to admin
  def contact_notice(contact)

    attachments.inline['logo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      @contact = contact
      @subject = get_subject
      # bes_services@citypower.com.tw
      mail(:to => [ 'adam@summers.com.tw, chris@summers.com.tw' ], :subject => "城市動力 客服信件(#{@subject})")
    end
  end

  
  def biz_contact_notice(contact)

    attachments.inline['logo.png'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do
      @contact = contact
      @subject = get_subject
      #service@citypower.com.tw
      mail(:to => [ 'adam@summers.com.tw, chris@summers.com.tw' ], :subject => "城市動力 客服信件(#{@subject})")
    end
  end

  private

  def with_logo_image
    File.read(File.join("public","images", "logo.png")) # inline img
  end

  def get_subject
    #預約試乘、意見回饋、其他  BES加盟系統、經銷代銷
    case @contact.subject
      when "testdrive"
        "預約試乘"
      when "opinion"
        "意見回饋"
      when "etc"
        "其他"
      when "bes"
        "BES加盟系統"
      when "coop"  
        "經銷代銷"
      else 
        ""
    end

  end
end
