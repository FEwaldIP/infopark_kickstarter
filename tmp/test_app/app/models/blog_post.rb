class BlogPost < Page
  cms_attribute :headline, type: :string
  cms_attribute :main_content, type: :widget
  cms_attribute :author_id, type: :string
  cms_attribute :author_name, type: :string
  cms_attribute :published_at, type: :date

  # Defines a reference to a blog associated with this page.
  def blog
    parent.blog
  end

  def disqus_shortname
    blog.disqus_shortname
  end

  def enable_comments?
    true
  end

  def next_post
    BlogPost.all
      .order(:published_at)
      .and(:published_at, :is_greater_than, published_at.utc.to_iso)
      .take(1)
      .first
  end

  def previous_post
    BlogPost.all
      .order(:published_at)
      .and(:published_at, :is_less_than, published_at.utc.to_iso)
      .reverse_order
      .take(1)
      .first
  end
end
