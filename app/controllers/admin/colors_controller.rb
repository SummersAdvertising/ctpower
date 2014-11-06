#encoding: utf-8
class Admin::ColorsController < AdminController
  
  before_action :set_vehicle, only: [:index, :new, :create, :edit, :update]
  before_action :set_color, only: [:edit, :update, :destroy]

  def index
    @colors = @vehicle.colors
  end

  def new
    @color = @vehicle.colors.new
  end

  def create
    @color = @vehicle.colors.new(color_params)

    respond_to do |format|
    if @color.save
        format.html { redirect_to admin_category_vehicle_colors_path(params[:category_id], params[:vehicle_id]), notice: 'successfully created.' }
      else
        @color = @vehicle.colors.new
        flash.now[:notice] = @color.errors.full_messages 
        format.html { render :new }
      end
    end

  end
  
  def edit 
    @gallery_count = @color.galleries.select{ |v| v['type'] == "VehicleColorDemo" }.count
  end

  def update

    #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@color.name}-feature-#{@color.galleries.count + 1}"
    end
    @latestAttach = VehicleColorDemo.create(:attachment => params[:attachment], :attachable => @color, :file_name => display_name) if params[:attachment]

    @color.update(color_params) 
    
    respond_to do |format|
      if @color.save
        format.html { redirect_to admin_category_vehicle_colors_path(params[:category_id], params[:vehicle_id]), notice: '更新成功' }
        #format.html { redirect_to admin_product_cate_product_path(@vehicle.product_cate_id, @vehicle) }
      else
        @gallery_count = @color.galleries.select{ |v| v['type'] == "VehicleColorDemo" }.count
        format.html { render :edit, notice: @color.errors.full_messages }
      end      
    end
  end

  def destroy

    @color.destroy
    
    redirect_to :back
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
  end

  def set_color
    @color = Color.find_by_id(params[:id])
  end

  def color_params
    params.require(:color).permit(:name, :hexcode)
  end

end