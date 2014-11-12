#encoding: utf-8
class ReservationsController < ApplicationController
  #new business reservation
  def index
    set_options
    @reservation = Reservation.new()
  end

  def create
    
    if verify_recaptcha
      @reservation = Reservation.create(reservation_params)

      respond_to do |format|
        if @reservation.save
          
          CtpowermailerJob.new.async.perform(CtpowerMailer, :contact_notice, @reservation)
          
          flash[:notice] = "已送出"
          format.html { redirect_to reservations_path() }
          
        else
          # @reservation = Reservation.new
          set_options
          # flash.now[:notice] = @reservation.errors.full_messages
          flash.now[:notice] = @reservation.errors.messages.values.flatten.join('<br />')
          format.html { render :index  }
        end
      end
    
    else
      @reservation = Reservation.new
      set_options
      flash.now[:alert] = "驗證碼錯誤"
      flash.delete :recaptcha_error
      render :index
    end

  end
  # Subject
  # 聯絡我們頁選項(單選)
  # 預約試乘、意見回饋、其他

  private

  def set_options
    @options = [["testdrive","預約試乘"],["opinion","意見回饋"],["etc","其他"]]
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params  
    params.require(:reservation).permit(:subject , :name, :email, :phone, :content)
  end
end