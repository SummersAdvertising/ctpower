#encoding: utf-8
class CtpowerMailer < ActionMailer::Base
  #require this lib when sending email by MailGun API
  require 'multimap'
  #default from: "Ladyboo <postmaster@sandbox6bfc02b6428d419186e8f7fa102fb7a1.mailgun.org>"
  #default from: "from@example.com"
  
  before_action :set_basic_data
  
  # send to user
  def contact_notice(contact)
    # attachments.inline['emaillogo.jpg'] = with_logo_image
    ActiveRecord::Base.connection_pool.with_connection do

      @contact = contact
      # through api: set params
      @data[:to] = [ 'adam@summers.com.tw' ]
      @data[:subject] = "通知" # 主旨
      @data[:html] = render_to_string('contact_notice').to_str # 內容
      # through api: set params end
      deliver_by_api(@data)

    end
  end

  private

  # MAILGUN
  def set_basic_data
    @data = Multimap.new
    @data[:from] = "Citypower <postmaster@sandbox6bfc02b6428d419186e8f7fa102fb7a1.mailgun.org>"
    #@data[:inline] = File.new(File.join("public","images","email", "maillogo.jpg")) # inline img
  end

  def deliver_by_api(data)
    RestClient.post "https://api:#{ Rails.application.config.action_mailer.mailgun_settings[:api_key]}@api.mailgun.net/v2/#{ Rails.application.config.action_mailer.mailgun_settings[:domain]}/messages", data.to_hash
  end

  # def with_logo_image
  #   File.read(File.join("public","images","email", "maillogo.jpg")) # inline img
  # end

end
