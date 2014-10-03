#encoding: utf-8
class Admin::FaqsController < AdminController
  #before_action :set_faq, only: [:show, :update ,:destroy]
  before_action :set_faq_with_box, only: [:create, :show]
  before_action :set_faq, only: [:edit,:update,:destroy]
  def index
    
  end

  def edit
    
  end

  def show
  
  end

  def create

    @faq = Faq.create()
    @faq.article = Article.new

    @box = Box.find_by_id(params[:box_id])
    @box.faqs << @faq

    respond_to do |format|
      if( @faq.errors.any? )
        format.html { redirect_to :back, alert: "新增失敗" }
      else
        format.html { redirect_to edit_admin_box_faq_path(@box, @faq) }
      end
    end

  end

  def update
    p params
    
    respond_to do |format|
      if @faq.update(faqs_params) && params[ :article ].nil? ^ @faq.article.update( params.require(:article).permit(:content) )
        format.html { redirect_to edit_admin_box_faq_path(params[:box_id],@faq), notice: 'Faq was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def destroy

    @faq.destroy
    
    redirect_to :back
  end

  private
    
    def set_faq
      @faq = Faq.find_by_id(params[:id])
    end

    def set_faq_with_box
      @faq = Faq.includes(:box).find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def faqs_params
      params.require(:faq).permit(:question, :article_id)
    end
end