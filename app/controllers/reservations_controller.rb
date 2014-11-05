#encoding: utf-8
class ReservationsController < ApplicationController
  #new business reservation
  def index
    @reservation = Reservation.new()
  end

  def create
    
    if verify_recaptcha
      @reservation = Reservation.create(reservation_params)

      respond_to do |format|
        if @reservation.save
          
          CtpowermailerJob.new.async.perform(CtpowerMailer, :contact_notice, @reservation)
          
          flash[:notice] = "更新成功"
          format.html { redirect_to reservations_path() }
          #format.js {render :js => "window.location.href=window.location.href;"}
        else
          @reservation = Reservation.new
          format.html { render :index , notice: @reservation.errors.full_messages }
        end
      end
    
    else
      @reservation = Reservation.new
      flash.now[:alert] = "驗證碼錯誤"
      flash.delete :recaptcha_error
      render :index
    end

  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params  
    params.require(:reservation).permit(:subject, :name, :email, :phone, :content)
  end
end