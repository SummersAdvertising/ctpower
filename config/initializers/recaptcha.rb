Recaptcha.configure do |config|

  if Rails.env.production?
    #citypower.com.tw
    config.public_key  = '6LcutwETAAAAAApO76YrrXBZOLj_wvFSZo8P88ci'
    config.private_key = '6LcutwETAAAAAC8OQiMSXt5fFdaAmOlo32Vgdj1f'
    #Temporary: li408-68
    #config.public_key  = '6LdSLv8SAAAAADxqajH-n9OAujouUpPlqV7CRPii'
    #config.private_key = '6LdSLv8SAAAAAGJEDHOBPRGkeP9W4ZPf7LZOQKFi'
    #Temporary: ctpower.summers.com.tw
    #config.public_key  = '6LcxNP0SAAAAAKeQ9dJMP0M-lVJavUPrZ3EsxBfG'
    #config.private_key = '6LcxNP0SAAAAAG0S4WVIgxZn3IN5r2TntJOUR28m'

  else
    #Temporary: citypower.com.tw
    config.public_key  = '6LcutwETAAAAAApO76YrrXBZOLj_wvFSZo8P88ci'
    config.private_key = '6LcutwETAAAAAC8OQiMSXt5fFdaAmOlo32Vgdj1f'

  end
end