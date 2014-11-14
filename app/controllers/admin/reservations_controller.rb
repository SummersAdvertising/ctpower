#encoding: utf-8
class Admin::ReservationsController < AdminController
  #new testdrive reservation
  def index
    @reservations = Reservation.new_asks.page(params[:page])
  end

  def history
    @reservations = Reservation.history_asks.page(params[:page])
  end

  def update
    @reservation = Reservation.find_by_id(params[:id])

    if(@reservation)
      @reservation.status = "done"
      @reservation.save
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

end