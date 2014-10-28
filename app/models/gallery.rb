class Gallery < ActiveRecord::Base
  
  mount_uploader :attachment, GalleryUploader
  
  belongs_to :attachable, :polymorphic => true
  
  validates :attachable, :presence => true
  validates :attachment, :presence => true


  before_save :set_attachment_attributes

  protected

  def set_attachment_attributes
    if attachment.present? && attachment_changed?
      self.content_type = attachment.file.content_type
      self.file_size = attachment.file.size

      #self.file_name = attachment.file.original_filename if !self.file_name.present?
    end
  end

end

#Banner
class IndexSliderGallery < Gallery

end

class ProductPhotoGallery < Gallery 

end
#Banner END

class AnnouncementCoverGallery < Gallery
end

#Vehicle
class VehicleCover < Gallery 

end

class VehicleDMFile < Gallery 

end

class VehicleAccessory < Gallery 

end

class VehicleFeature < Gallery 

end

class VehicleSlider < Gallery 

end

class VehicleColorDemo < Gallery 

end

class VehiclePhotoGallery < Gallery 

end
#Vehicle END

#Station
class StationPhotoGallery < Gallery
  
end
#Station END
