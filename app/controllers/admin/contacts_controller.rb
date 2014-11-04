class Admin::ContactsController < AdminController
  #new business contact
  def index
    @contacts = Contact.order(created_at: :desc).page(params[:page])
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  # def contact_params  
  #   params.require(:contact).permit(:subject, :name, :email, :phone, :content)
  # end
end