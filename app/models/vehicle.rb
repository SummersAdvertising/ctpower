#encoding: utf-8
class Vehicle < ActiveRecord::Base

  belongs_to :category
  
  has_many :specs, dependent: :destroy
  has_many :features, dependent: :destroy
  has_many :colors, dependent: :destroy
  has_many :accessories, dependent: :destroy

  has_many :galleries, -> { order('ranking, created_at') } , as: :attachable , dependent: :destroy

  #before_destroy { |record| Banner.destroy_all "related_vehicle_id = #{record.id}"  }
  scope :front_show_by_cate, ->(category_id) { where("category_id = ? AND status = ?", category_id, "enable") }

  store :context, accessors: [ :context_1, :context_2, :context_3 ]

  before_validation :check_attrs
  #callback
  after_create :create_default_specs

  validates_presence_of :name, :title_color

  private

  def check_attrs
    self.name = "未命名車款" if self.name.blank?
    self.status = "enable" if self.status.blank?
    self.title_color = "000000" if self.title_color.blank?
  end

  def create_default_specs
    
    #k-v pair: title:context
    @default_specs = [
      {title: '電機型式', context: ''},
      {title: '電機瓦數', context: ''},
      {title: '制動系統', context: ''},
      {title: '懸吊系統', context: ''},
      {title: '電池容量', context: ''},
      {title: '電池組數', context: ''},
      {title: '最高時速', context: ''},
      {title: '經濟速度', context: ''},
      {title: '里程'   , context: ''},
      {title: '爬坡效能', context: ''},
      {title: '檔位變換', context: ''}
    ]

    @default_specs.each do | spec |
      spec.reverse_merge!(vehicle_id: self.id )
    end     
    
    Spec.create(@default_specs)

  end

end
