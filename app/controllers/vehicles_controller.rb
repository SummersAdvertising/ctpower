#encoding: utf-8
class VehiclesController < ApplicationController

  def show
  
    @vehicle = Vehicle.where(status: 'enable').includes(:galleries, :colors, :features, :specs, :accessories).find_by_id(params[:id])

    if @vehicle
      @features = @vehicle.features.includes(:galleries)
      @com_accessories = @vehicle.accessories.where(type:'ComplimentaryAccessory').includes(:galleries)
      @opt_accessories = @vehicle.accessories.where(type:'OptionalAccessory').includes(:galleries)
    else
      redirect_to vehicles_pages_path
    end

  end

end
