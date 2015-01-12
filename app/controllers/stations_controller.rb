#encoding: utf-8
class StationsController < ApplicationController
  
  before_action :set_station, only: [:show]

  def index

    @countries = Country.all #use it when country selectable
    @cities = City.where("country_id = ?", Country.first.id)
    @districts = District.where("city_id = ?", City.first.id)

    @q = Station.search(params[:q])

  end

  def search
    
    @q = Station.search(params[:q])
    @stations = @q.result(distinct: true).includes(:galleries)

    if @stations.count <= 0
      
      if params[:q]['city_eq']
         target_city = City.where(id: params[:q]['city_eq'].to_i).limit(1).pluck(:name)
         @target_city_name = target_city[0] if target_city
      end

      if params[:q]['district_eq']
        target_district = District.where(id: params[:q]['district_eq'].to_i).limit(1).pluck(:name)
        @target_district_name = target_district[0] if target_district
      end

    end

    respond_to do |format|
      format.js
    end    
    
  end

  def show
    
  end

  def fetch_from_country
    @cities = City.where("country_id = ?", params[:country_id])
    @districts = District.where("city_id = ?", @cities.first.id)
    respond_to do |format|
      format.js
    end    
  end

  def fetch_from_city 
    
    @districts = District.where("city_id = ?", params[:city_id])
    respond_to do |format|
      format.js
    end    
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_station
    @station = Station.find(params[:id])
  end

end