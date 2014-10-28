#encoding: utf-8
class Admin::StationsController < AdminController
  
  #helper_method :sort_column, :sort_direction
  
  before_action :set_station, only: [:show, :edit, :update, :destroy, :stationphoto_upload, :create_station_attachment]

  def index
    
    #<%= sort_link @q , :payment_type, "付款方式" %>
    @stations = Station.page(params[:page])
    #@station = Station.new
  end

  def new
    @station = Station.new

    @countries = Country.all #use it when country selectable
    @cities = City.where("country_id = ?", Country.first.id)
    @districts = District.where("city_id = ?", City.first.id)

  end
    
  def create

    @station = Station.new(station_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to admin_stations_path(), notice: 'station was successfully created.' }
      else
        format.html { redirect_to :back, notice: @station.errors.full_messages }
      end
    end

  end

  def show
    #.pluck(:name, :lat, :lng).to_json
    nearby_info = Station.within(5, origin: @station)
    @info_array = Array.new
    nearby_info.each do |station|
      
      if station.galleries.select{ |v| v['type'] == "StationPhotoGallery"  }.first
        a = station.galleries.select{ |v| v['type'] == "StationPhotoGallery"  }.first.attachment.url 
      end

      temp = [render_to_string(partial: 'info_window', :layout => false, locals: {station: station})]
      @info_array.push(temp)
    end 
    
  end

  # GET /admin/stations/1/edit
  def edit
    
    @cities = City.where("country_id = ?", @station.country)
    @districts = District.where("city_id = ?", @station.city)
    #get all tag by context
    #@all_tag_with_context = ActsAsTaggableOn::Tagging.where(:context => 'services').joins(:tag).select('DISTINCT tags.name').map{ |x| x.name}

  end

  # tab-2: station photo uploads
  def stationphoto_upload
    @gallery_count = @station.galleries.select{ |v| v['type'] == "StationPhotoGallery" }.count
  end

  def create_station_attachment
      #deal with attachment
    if params[:filename].present? 
      display_name = params[:filename] 
    else 
      display_name = "#{@station.name}-STORE-#{@station.galleries.count + 1}"
    end
    @latestAttach = StationPhotoGallery.create(:attachment => params[:attachment], :attachable => @station, :file_name => display_name) if params[:attachment]
    
    respond_to do |format|
       format.html { redirect_to stationphoto_upload_admin_station_path(@station), notice: 'station photo was successfully created.' }
       #format.js {render :js => "window.location.href=window.location.href"}
    end
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


  # PATCH/PUT /admin/stations/1
  # PATCH/PUT /admin/stations/1.json
  def update

    respond_to do |format|
      if @station.update(station_params)
        format.html { redirect_to :back, notice: '更新成功' }
        format.json { head :no_content }
      else
        format.html { render action: :back }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stations/1
  # DELETE /admin/stations/1.json
  def destroy

    #也要處理相關tags的刪除？

    @station.destroy
    respond_to do |format|
      format.html { redirect_to admin_stations_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_station
    #@station = Station.friendly.find(params[:id])
    @station = Station.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def station_params
    params.require(:station).permit(:name, :address, :intro, :phone, :address, :country, :city, :district, :ophour, :latlng, :location_list , :lat, :lng  )
  end

  #change implementation to ransack
  # def sort_column
  #   Station.column_names.include?(params[:sort]) ? params[:sort] : "name"
  # end
  
  # def sort_direction
  #   %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  # end

end