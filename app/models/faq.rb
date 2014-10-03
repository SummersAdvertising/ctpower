#encoding: utf-8
class Faq < ActiveRecord::Base
  belongs_to :box
  belongs_to :article, :dependent => :destroy

  scope :front_show_by_box, ->(category_id) { where("box_id = ? AND status = ?", box_id, "enable") }
  
end
