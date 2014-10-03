#encoding: utf-8
class Admin::BoxesController < AdminController
  before_action :set_box, only: [:update ,:destroy]

  def index
    @box = Box.new
    @boxes = Box.for_admin.where("depth = 1")
  end

  def show
    @box = Box.includes(:faqs).find(params[:id])
    @boxes = Box.where("parent_id = #{@box.id}")
    @new_box = Box.new
    @breadcrumb = @box.find_my_direct_parent
  end

  def create

    @box = Box.new(box_params)
    @box.save

    # if params[:filename].present? 
    #   display_name = params[:filename]
    # else 
    #   display_name = "#{@box.name}-CATEGORY-#{@box.galleries.count + 1}"
    # end
      
    # @latestAttach = BoxCoverGallery.create(:attachment => params[:attachment], :attachable => @box, :file_name => display_name) if params[:attachment]


    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def update

    # if params[:filename].present? 
    #   display_name = params[:filename]
    # else 
    #   display_name = "#{@box.name}-CATEGORY-#{@box.galleries.count + 1}"
    # end
      
    # @latestAttach = BoxCoverGallery.create(:attachment => params[:attachment], :attachable => @box, :file_name => display_name) if params[:attachment]
    
    @box.update_attributes(box_params) if @box

    redirect_to :back
  end

  def destroy

    #@box.destroy if @box && @box.faqs.count == 0
    deletable = true
    if @box.faqs.count > 0
      flash[:alert] = "此分類下仍有項目 無法刪除" 
      deletable = false
    end
    
    # prevent delete by mistake
    Box.where(id: @box.descendents).each do |box|
      if box.faqs.count > 0
        flash[:alert] = "分類 [#{box.name}] 下仍有項目 無法刪除"
        deletable = false
        break
      end
    end
    
    @box.destroy if deletable == true
    
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box
      @box = Box.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_params
      params.require(:box).permit(:name, :parent_id, :depth, :attachment)
    end

end