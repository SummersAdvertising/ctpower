#encoding: utf-8
class Admin::ReservationsController < AdminController
  #new business contact
  def index
    @reservations = Reservation.order(created_at: :desc).page(params[:page])
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  # def contact_params  
  #   params.require(:contact).permit(:subject, :name, :email, :phone, :content)
  # end
end