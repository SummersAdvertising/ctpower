Recaptcha.configure do |config|

  if Rails.env.production? 
    #Temporary: li408-68
    config.public_key  = '6LdSLv8SAAAAADxqajH-n9OAujouUpPlqV7CRPii'
    config.private_key = '6LdSLv8SAAAAAGJEDHOBPRGkeP9W4ZPf7LZOQKFi'
    #Temporary: ctpower.summers.com.tw
    #config.public_key  = '6LcxNP0SAAAAAKeQ9dJMP0M-lVJavUPrZ3EsxBfG'
    #config.private_key = '6LcxNP0SAAAAAG0S4WVIgxZn3IN5r2TntJOUR28m'

  else 
    #Temporary: www.citypower.com.tw, because localhost is ok
    config.public_key  = '6LcBNf0SAAAAAEfitPESm4zYo3Xml6FhpIERfm02'
    config.private_key = '6LcBNf0SAAAAAFsz6lrQ8hgFGIvXnyarJSPM-mSn'
    
  end
end