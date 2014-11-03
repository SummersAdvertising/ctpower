class ReservationsController < ApplicationController
  #new business reservation
  def index
    @reservation = Reservation.new()
  end

  def create
    
    @reservation = Reservation.create(reservation_params)

    respond_to do |format|
      if @reservation.save
       
        flash[:notice] = "更新成功"
        format.html { redirect_to reservations_path() }
        #format.js {render :js => "window.location.href=window.location.href;"}
      else
        format.html { redirect_to :back , notice: @reservation.errors.full_messages }
      end
    end

  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params  
    params.require(:reservation).permit(:subject, :name, :email, :phone, :content)
  end
end