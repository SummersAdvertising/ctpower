#encoding: utf-8
class StaticsController < ApplicationController
  layout false , only: [:index]

  def index
    @boxes = Box.all
    @faqs = Box.last.faqs
  end

  def about

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
