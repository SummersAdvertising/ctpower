#encoding: utf-8
class Admin::SpecsController < AdminController
  
  before_action :set_vehicle, only: [:index, :new, :create, :edit, :update]
  before_action :set_spec, only: [:edit, :update]

  def index
    @specs = @vehicle.specs
  end

  def new
    @spec = @vehicle.specs.new
  end

  def create
    @spec = @vehicle.specs.new(spec_params)

    respond_to do |format|
    if @spec.save
        format.html { redirect_to admin_category_vehicle_specs_path(params[:category_id], params[:vehicle_id]), notice: 'successfully created.' }
      else
        flash.now[:notice] = @spec.errors.full_messages 
        format.html { render :new }
      end
    end

  end
  
  def edit 

  end

  def update
    @spec.update(spec_params) 
    
    respond_to do |format|
      if @spec.save
        format.html { redirect_to :back, notice: '更新成功' }
        #format.html { redirect_to admin_product_cate_product_path(@vehicle.product_cate_id, @vehicle) }
      else
        format.html { render :back, notice: @spec.errors.full_messages }
      end      
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find_by_id(params[:vehicle_id])
  end

  def set_spec
    @spec = Spec.find_by_id(params[:id])
  end

  def spec_params
    params.require(:spec).permit(:title, :context)
  end

end