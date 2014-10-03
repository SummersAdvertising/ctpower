class Color < ActiveRecord::Base

  belongs_to :vehicle
  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy
  
end
