#encoding: utf-8
module ReservationsHelper

  def get_reservation_status(reservation)
    if reservation.status == "new"
      link_to( "已處理", admin_reservation_path(reservation), :method => "put" , class: "uvs")
    else 
      "已處理"
    end
  end
  
end