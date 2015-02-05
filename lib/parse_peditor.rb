#encoding: utf-8
module ParsePeditor
  include ActionView::Helpers
  include ActionView::Context

  def parse_peditor

    unless self.article.content.blank?
      article = JSON.parse(self.article.content)
      #then iterate
      content_tag(:section, self.article.content ,class: 'text text-show',id: 'articleContent') do 
        
        article.each do | peditor_part |
          case peditor_part['type']
            when 'p'
              concat( parse_peditor_p(peditor_part) )
            when 'img'
              concat parse_peditor_img(peditor_part)
            when 'list'
              concat parse_peditor_list(peditor_part)
            when 'video'
              concat parse_peditor_video(peditor_part)
            else
          end # end case 
        end # end each

      end
    else
      
    end

  end

  def parse_peditor_p(peditor_part)
    
    content = peditor_part['content'].gsub(/[\n\r]/,"<br>\n");
    # content = simple_format(peditor_part['content'])

    # set content class
    content_class = 'part'
    unless peditor_part['fontClass'].blank?
      content_class = peditor_part['fontClass']
    end # end set content class
    
    # if set link
    unless peditor_part['link'].blank?
      content_tag(:div, "",class: '', data: { type: 'p'}) do 
        concat( content_tag(:p, link_to(content.html_safe, peditor_part['link'] ) ,class: content_class) )
      end
    else
      content_tag(:div, "",class: '', data: { type: 'p'}) do 
        concat( content_tag(:p, content.html_safe ,class: content_class) )
      end
    end

  end

  def parse_peditor_img(peditor_part)
    content_tag(:div, "" ,class: '', data: { type: 'img'}) do 
      concat( image_tag( peditor_part['path'] , alt: peditor_part['id'], title: peditor_part['id']) )
    end
  end

  def parse_peditor_video(peditor_part)
    content_tag(:div, "" ,class: '', data: { type: 'video'}) do 
      content_tag(:iframe, nil, src: peditor_part['embedcode'], class: 'embed-responsive-item')
    end
  end

  def parse_peditor_list(peditor_part)
    li_items = peditor_part['content']
    css_class = peditor_part['style']

    content_tag(:div, "" ,class: '', data: { type: 'list'}) do 
      content_tag(:ul, class: css_class) do
        li_items.each do |item|
          concat content_tag(:li, item)
        end
      end
    end
  end

end