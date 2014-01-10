class TextImageWidget < Widget
  def image_top_order?
    align != 'bottom'
  end
end
