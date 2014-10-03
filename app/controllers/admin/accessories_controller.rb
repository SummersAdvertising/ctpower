#encoding: utf-8
class Admin::AccessoriesController < AdminController
  
  before_action :set_vehicle, only: [:index, :new, :create, :edit, :update]
  before_action :set_accessory, only: [:create, :edit, :update]

  before_action :set_accessory_types, only: [:new, :edit]

  def index
    @accessories = @vehicle.accessories
  end

  def new
    @accessory = @vehicle.accessories.new
  end

  def create

    @accessory = @vehicle.accessories.new(params.require(:accessory).permit(:title, :context, :type)  )

    respond_to do |format|
    if @accessory.save
        format.html { redirect_to edit_admin_category_vehicle_accessory_path(params[:category_id], params[:vehicle_id], @accessory), notice: 'successfully created.' }
      else
        flash.now[:notice] = @accessory.errors.full_messages 
        format.html { render :new }
      end
    end

  end
  
  def edit 
    @gallery_count = @accessory.galleries.select{ |v| v['type'] == "VehicleAccessory" }.count
  end

  def update
    #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@accessory.title}-accessory-#{@accessory.galleries.count + 1}"
    end
    @latestAttach = VehicleAccessory.create(:attachment => params[:attachment], :attachable => @accessory, :file_name => display_name) if params[:attachment]


    @accessory.update(accessory_params) 
    
    respond_to do |format|
      if @accessory.save
        format.html { redirect_to :back, notice: '更新成功' }
        #format.html { redirect_to admin_product_cate_product_path(@vehicle.product_cate_id, @vehicle) }
      else
        format.html { render :back, notice: @accessory.errors.full_messages }
      end      
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
  end

  def set_accessory
    @accessory = Accessory.find_by_id(params[:id])
  end

  def set_accessory_types
    @accessory_types = [['附贈','ComplimentaryAccessory'],['選配','OptionalAccessory']] 
  end

  def accessory_params

    if accessory_type == 'ComplimentaryAccessory'
      params.require(:complimentary_accessory).permit(:title, :description)
    elsif accessory_type == 'OptionalAccessory'
      params.require(:optional_accessory).permit(:title, :description, :related_product_id, :status)
    end
    
  end

  def accessory_types
    ["ComplimentaryAccessory", "OptionalAccessory"]
  end

  def accessory_type

    if !params[:type].nil?
      params[:type] if params[:type].in? accessory_types
    else
      @accessory.type if @accessory.type.in? accessory_types
    end
  end

end