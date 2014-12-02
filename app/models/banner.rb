#encoding: utf-8
class Banner < ActiveRecord::Base
  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy

  before_validation :check_attrs
  validates_presence_of :description, unless: :is_index_slider?

  scope :sliders, -> { where(type: 'IndexSlider') } 
  scope :vehicles, -> { where(type: 'SelectedVehicle') } 

  delegate :index_sliders, :selected_vehicles, to: :banners

  def is_index_slider?
      self.type == 'IndexSlider'
  end

  def check_attrs
    self.title = "未命名 Banner" if self.title.blank?
    self.description = " " if self.description.blank?
    
    if self.is_index_slider?
      self.status = "enable"
      self.description = "javascript:void(0);" if self.description.blank?
    else
      self.status = "disable" if self.status.blank?
    end
    
    self.related_product_id = 0 if self.related_product_id.blank?
  end

  def get_status
    case self.status
    when "disable"
      "下架"
    when "enable"
      "上架"
    end   
  end

  def is_available?
    self.status == "enable" ? true : false
  end

end

class IndexSlider < Banner
  
end

class SelectedVehicle < Banner
  belongs_to :vehicles

end
