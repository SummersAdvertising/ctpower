#encoding: utf-8
class StaticsController < ApplicationController

  def index
    @announcements = Announcement.includes(:galleries).for_index.limit(3)
  end

  def about

  end

  def vehicles
    @categories = Category.includes(:vehicles).where(depth: 1)
  end

  def show
  
    if params[ :page ].nil?
      redirect_to :index
    end
    
    respond_to do | format |
      format.html { render :template => 'statics/' + params[ :page ]  rescue redirect_to '/errors' }
    end
    
  end

end
