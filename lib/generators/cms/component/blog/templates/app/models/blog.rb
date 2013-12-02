class Blog < Obj
  include Page

  cms_attribute :headline, type: :string
  cms_attribute :show_in_navigation, type: :boolean
  cms_attribute :sort_key, type: :string
  cms_attribute :disqus_shortname, type: :string

  # Defines a reference to a blog associated with this page.
  def blog
    self
  end

  def latest_posts(count, page = 0)
    BlogPost.all
      .and(:_path, :starts_with, path + '/')
      .offset(page * count)
      .batch_size(count)
      .order(:published_at)
      .reverse_order
      .take(count)
  end
end
