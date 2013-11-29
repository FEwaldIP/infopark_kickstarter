class Blog < Obj
  include Page

  cms_attribute :headline, type: :string
  cms_attribute :show_in_navigation, type: :boolean
  cms_attribute :sort_key, type: :string
  cms_attribute :disqus_shortname, type: :string
  cms_attribute :description, type: :text

  # Defines a reference to a blog associated with this page.
  def blog
    self
  end

  def latest_posts(count = 10)
    BlogPost.all
      .and(:_path, :starts_with, path + '/')
      .batch_size(100)
      .order(:_valid_from)
      .reverse_order
      .take(count)
  end
end
