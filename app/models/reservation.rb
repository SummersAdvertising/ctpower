#encoding: utf-8
class Reservation < ActiveRecord::Base

  validates_presence_of :name, :subject, :email, :phone, :content

end
