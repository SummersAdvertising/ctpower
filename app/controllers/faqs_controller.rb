#encoding: utf-8
class FaqsController < ApplicationController
  # before_action :set_faq, only: [:show]
  
  # def index
  #   @boxes = Box.without_root_node
  #   @faqs = @boxes.first.faqs
  # end

  # def show
  #   @boxes = Box.without_root_node
  #   @faqs = @boxes.first.faqs
  # end

  def fetch_by_box
    @faq = Faq.find_by_id(params[:id])
    respond_to do |format|
      if(@faq)
        #@content = @faq.article.content
        format.js
      else
        format.html { redirect_to faqs_path(), alert: "找不到QA" }
      end
    end
    
  end

  private
    
    # def set_faq
    #   @faq = Faq.find_by_id(params[:id])
    # end

end