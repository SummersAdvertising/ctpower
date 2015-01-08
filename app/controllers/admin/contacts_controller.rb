#encoding: utf-8
class Admin::ContactsController < AdminController
  #new business contact
  def index
    @contacts = Contact.new_asks.page(params[:page])
  end

  def history
    @contacts = Contact.history_asks.page(params[:page])
  end

  def update
    @contact = Contact.find_by_id(params[:id])

    if(@contact)
      @contact.status = "done"
      @contact.save
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end
  
  def reset_status
    @contact = Contact.find_by_id(params[:id])

    if(@contact)
      @contact.status = "new"
      @contact.save
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def soft_delete
    @contact = Contact.find_by_id(params[:id])

    if(@contact)
      @contact.status = "dead"
      @contact.save
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

end