#encoding: utf-8
class Contact < ActiveRecord::Base

  validates_presence_of :name, :subject, :email, :phone, :content

end
