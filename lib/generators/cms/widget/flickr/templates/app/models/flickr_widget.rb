class FlickrWidget < Widget
  def src
    "http://www.flickr.com/badge_code_v2.gne?count=#{count}&display=#{sort}&size=#{size_type}&layout=#{layout_type}#{source_url}"
  end

  private

  def source_url
    case source_type
    when 'user' then
      "&source=user&user=#{source}"
    when 'group' then
      "&source=group&group=#{source}"
    when 'user_set' then
      "&source=user_set&set=#{source}"
    when 'all_tag' then
      "&source=all_tag&tag=#{source}"
    end
  end

  def layout_type
    case layout
    when 'horizontal' then 'h'
    when 'verticle' then 'v'
    when 'not-styled' then 'x'
    end
  end

  def size_type
    case size
    when 'medium' then 'm'
    when 'square' then 's'
    when 'thumbnail' then 't'
    end
  end
end
