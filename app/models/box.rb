#encoding: utf-8
class Box < ActiveRecord::Base
  has_many :faqs, dependent: :destroy

  belongs_to :daddy, :class_name => "Box", :foreign_key => 'parent_id' 
  has_many :children,  :class_name => "Box", :foreign_key => 'parent_id'

  scope :for_admin, -> { where( "parent_id != 0" ) }
  scope :without_root_node, -> { where( "parent_id != 0 AND depth = 1" ) }

  def self.return_root_node
    return Box.find_by('parent_id=0')
  end

  def self.get_level_hierarchy()
    
    if Rails.env.production?
      sql = "SELECT boxes.id, boxes.depth, boxes.parent_id, boxes.name FROM boxes WHERE  boxes.parent_id != 0 "
    else
      #local
      sql = "SELECT boxes.id, boxes.depth, boxes.parent_id, boxes.name FROM boxes WHERE boxes.parent_id != 0 "
    end

    return records_array = ActiveRecord::Base.connection.execute(sql)

  end

  #should be useful to create breadcrum
  def find_my_direct_parent
    
     self.findpapa
     directparents = @@directparent.dup
     @@directparent.clear
     
     return directparents
     
  end
  
  #find direct parent levle mainly for breadcrumb
  @@directparent = []
  def findpapa

    if self.parent_id == 0
        @@directparent << self
       return @@directparent
    end   
    
    if self.parent_id > 0  
        @@directparent << self
        daddy.findpapa
    end
    
  end

  def delete_children
    Box.destroy_all(id: self.descendents)
  end

  def descendents
    #children.preload(:parent).each do |child|  child.descendents end
   children.each do |child|
      [child] + child.descendents
    end
  end


end
