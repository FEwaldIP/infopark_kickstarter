xml.item do
  xml.title post.headline
  xml.pubDate post.published_at.to_s(:rfc822)
  xml.description truncate(strip_tags(cms_tag(:div, post, :main_content)), length: 150)
  xml.link cms_url(post)
  xml.guid cms_url(post)
end
