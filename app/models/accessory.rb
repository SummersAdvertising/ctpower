class Accessory < ActiveRecord::Base

  belongs_to :vehicle
  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy

  before_validation :check_attrs
  validates_presence_of :title, :context, :type

  private

  def check_attrs
    self.title = "未命名配件" if self.title.blank?
    self.context = "說明文字" if self.context.blank?
    self.type = "OptionalAccessory" if self.type.blank?
  end

end

class OptionalAccessory < Accessory

end

class ComplimentaryAccessory < Accessory

end