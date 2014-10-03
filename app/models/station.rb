#encoding: utf-8
class Station < ActiveRecord::Base
  
  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy

  default_scope { order('city ASC, district ASC') }
  
  before_validation :check_attrs
  validates_presence_of :name 

  paginates_per 10

  def check_attrs
    self.name = "untitled" if self.name.blank?
  end
  
end
