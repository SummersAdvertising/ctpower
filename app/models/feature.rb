class Feature < ActiveRecord::Base

  belongs_to :vehicle
  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
  
  validates_presence_of :title, :context

end
