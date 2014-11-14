#encoding: utf-8
class Contact < ActiveRecord::Base
  
  validates_presence_of :name, :message => "姓名不能為空白"
  validates_presence_of :content, :message => "留言不能為空白"
  
  validates_presence_of :email, :message => "Email不能為空白"
  validates :email, :format => { :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :message => 'E-Mail 格式不符'  }
  validates_presence_of :phone, :message => "請輸入電話"
  validates :phone, :format => { :with =>/[- #)(0-9]{4,10}[- #)(0-9]{4,10}/, :message => '聯絡電話 格式不符' }

  scope :new_asks, -> { where(status: 'new').order(created_at: :asc)}
  scope :history_asks, -> { where(status: 'done').order(created_at: :desc) }

  paginates_per 25

  before_validation :check_attrs
  
  def check_attrs
    self.status = "new" if self.status.blank?
  end

  def get_status
    case self.status
    when "new"
      "未處理"
    when "done"
      "已處理"
    end
  end

end
