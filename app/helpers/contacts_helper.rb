#encoding: utf-8
module ContactsHelper

  def get_contact_status(contact)
    if contact.status == "new"
      link_to( "已處理", admin_contact_path(contact), :method => "put" , class: "uvs")
    else 
      "已處理"
    end
  end

  def reset_contact_status(contact)
    link_to( "設為未處理", reset_status_admin_contact_path(contact), :method => "put" , class: "uvs")
  end

  def soft_delete_contact(contact)
    link_to( "刪除", soft_delete_admin_contact_path(contact), :method => "put" , class: "uvs")
  end

  def get_subject(contact)
    #預約試乘、意見回饋、其他  BES加盟系統、經銷代銷
    case contact.subject
      when "testdrive"
        return "預約試乘"
      when "opinion"
        return "意見回饋"
      when "etc"
        return "其他"
      when "bes"
        return "BES加盟系統"
      when "coop"  
        return "經銷代銷"
      else 
        return ""
    end

  end

end