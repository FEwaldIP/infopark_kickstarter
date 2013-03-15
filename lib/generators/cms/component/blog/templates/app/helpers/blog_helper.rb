module BlogHelper

  def tag_path(blog, tag)
    "#{cms_path(blog)}?tag=#{tag}"
  end

  def tag_link_list
    links = []
    @entry.tags.each do |tag|
      links << link_to(tag, tag_path(@entry.blog, tag))
    end

    (links * ' | ').html_safe
  end

  def rss_feed_path
    feed_path('rss')
  end

  def atom_feed_path
    feed_path('atom')
  end

  private

  def feed_path(type)
    path = "#{cms_path(find_blog_obj)}.#{type}"
    path += '?_rc-ws=rtc' if RailsConnector::Workspace.current.id.eql?('rtc')
  end

  def find_blog_obj
    return @blog if @blog.present?

    obj = @obj
    obj = obj.parent while !obj.class.eql?(Blog)

    obj
  end

  def author_image_path_for_entry(entry)
    user_id = entry.author_id
    @user_image_service ||= ::UserImageService.new
    @user_image_service.image_path(user_id)
  end

  def author_name(entry)
    if entry.author.present?
      [
        entry.author.first_name,
        entry.author.last_name
      ].compact.join(' ')
    else
      ''
    end
  end

  def author_email(entry)
    entry.author.try(:email)
  end
end