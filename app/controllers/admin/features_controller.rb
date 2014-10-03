#encoding: utf-8
class Admin::FeaturesController < AdminController

  before_action :set_vehicle, only: [:index, :new ,:create ,:edit, :update]
  before_action :set_feature, only: [:edit, :update]

  def index
    @features = @vehicle.features
  end
  
  def new
    @feature = @vehicle.features.new
  end

  def create

    @feature = @vehicle.features.new(feature_params)

    respond_to do |format|
    if @feature.save
        format.html { redirect_to edit_admin_category_vehicle_feature_path(params[:category_id], params[:vehicle_id], @feature), notice: 'successfully created.' }
      else
        format.html { redirect_to :back, notice: @feature.errors.full_messages }
      end
    end

  end

  def edit 
    @gallery_count = @feature.galleries.select{ |v| v['type'] == "VehicleFeature" }.count
  end

  def update
    
    #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@feature.title}-feature-#{@feature.galleries.count + 1}"
    end
    @latestAttach = VehicleFeature.create(:attachment => params[:attachment], :attachable => @feature, :file_name => display_name) if params[:attachment]

    @feature.update(feature_params) 
    
    respond_to do |format|
      if @feature.save
        format.html { redirect_to admin_category_vehicle_features_path, notice: '更新成功' }
        #format.html { redirect_to admin_product_cate_product_path(@vehicle.product_cate_id, @vehicle) }
      else
        format.html { render :back, notice: @feature.errors.full_messages }
      end      
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
  end

  def set_feature
    @feature = Feature.find_by_id(params[:id])
  end

  def feature_params
    params.require(:feature).permit(:title, :context, :attachment)
  end
  
end