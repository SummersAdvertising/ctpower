 #encoding: utf-8
class Admin::VehiclesController < AdminController
  
  before_action :set_vehicle_with_category, only: [:create, :show]
  before_action :set_vehicle, only: [:edit,:update,:destroy]
  #before_action :get_vehicle_cate, only: [:create]
  
  def show
    @com_accessories = @vehicle.accessories.where(type: 'ComplimentaryAccessory').includes(:galleries)
    @opt_accessories = @vehicle.accessories.where(type: 'OptionalAccessory').includes(:galleries)
    @features = @vehicle.features.includes(:galleries)
    @colors = @vehicle.colors.includes(:galleries)
    @cover = @vehicle.galleries.where(type: 'VehicleCover')
    @sliders = @vehicle.galleries.where(type: 'VehicleSlider') 
    @photos = @vehicle.galleries.where(type: 'VehiclePhotoGallery')
    @dms = @vehicle.galleries.where(type: 'VehicleDMFile')
  end

  def create

    @vehicle = Vehicle.create()

    @category = Category.find_by_id(params[:category_id])
    @category.vehicles << @vehicle

    respond_to do |format|
      if( @vehicle.errors.any? )
        format.html { redirect_to :back, alert: "新增失敗" }
      else
        format.html { redirect_to edit_admin_category_vehicle_path(@category, @vehicle) }
      end
    end
  end

  def edit
    @gallery_count = @vehicle.galleries.select{ |v| v['type'] == "VehicleCover" }.count
  end

  def slider
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
    @gallery_count = @vehicle.galleries.select{ |v| v['type'] == "VehicleSlider" }.count
  end

  def upload_slider
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
    #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@vehicle.name}-vehicle-#{@vehicle.galleries.count + 1}"
    end
    @latestAttach = VehicleSlider.create(:attachment => params[:attachment], :attachable => @vehicle, :file_name => display_name) if params[:attachment]

    @vehicle.update(vehicle_params) 
    
    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to :back, notice: '更新成功' }
      else
        format.html { render :back, notice: @vehicle.errors.full_messages }
      end      
    end

  end

  def dm
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
    @gallery_count = @vehicle.galleries.select{ |v| v['type'] == "VehicleDMFile" }.count
  end

  def upload_dm
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
    #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@vehicle.name}-vehicle-#{@vehicle.galleries.count + 1}"
    end
    @latestAttach = VehicleDMFile.create(:attachment => params[:attachment], :attachable => @vehicle, :file_name => display_name) if params[:attachment]

    @vehicle.update(vehicle_params) 
    
    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to :back, notice: '更新成功' }
      else
        format.html { render :back, notice: @vehicle.errors.full_messages }
      end      
    end
  end

  def photo
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
    @gallery_count = @vehicle.galleries.select{ |v| v['type'] == "VehiclePhotoGallery" }.count
  end

  def upload_photo
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
    #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@vehicle.name}-vehicle-#{@vehicle.galleries.count + 1}"
    end
    @latestAttach = VehiclePhotoGallery.create(:attachment => params[:attachment], :attachable => @vehicle, :file_name => display_name) if params[:attachment]

    @vehicle.update(vehicle_params) 
    
    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to :back, notice: '更新成功' }
      else
        format.html { render :back, notice: @vehicle.errors.full_messages }
      end      
    end
  end
  
  def update

    #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@vehicle.name}-vehicle-#{@vehicle.galleries.count + 1}"
    end
    @latestAttach = VehicleCover.create(:attachment => params[:attachment], :attachable => @vehicle, :file_name => display_name) if params[:attachment]

    @vehicle.update(vehicle_params.merge({:status => "enable"})) 
    
    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to :back, notice: '更新成功' }
        #format.html { redirect_to admin_product_cate_product_path(@vehicle.product_cate_id, @vehicle) }
      else
        format.html { render :edit, notice: @vehicle.errors.full_messages }
      end      
    end

  end

  def reorder
    errorFlag = false
    params[:vehicles][:reorderset].each_with_index do | id , index |
      the_id = Vehicle.find(id)
      if !the_id.nil?
        the_id.update_attribute(:ranking , index+1 )
      else
        errorFlag = true
      end
    end

    respond_to do |format|
      if errorFlag
        format.json { head :no_content }
      else
        # flash[:notice] = "重新排序成功"
        format.json do render json: flash end
      end
    end

  end  

  def destroy
    
    @vehicle.destroy
    
    redirect_to :back
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find_by_id(params[:id])
  end

  def set_vehicle_with_category
    @vehicle = Vehicle.includes(:category).find_by_id(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:name, :price, :price_for_sale, :intro,:context_1, :context_2, :context_3, :attachment, :status, :cf, :description, :title_color)
  end

end
 