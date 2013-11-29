class BlogPost < Obj
  include Page

  cms_attribute :headline, type: :string
  cms_attribute :main_content, type: :widget
  cms_attribute :abstract, type: :html
  cms_attribute :author, type: :string

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
      .order(:_valid_from)
      .and(:_valid_from, :is_greater_than, valid_from.utc.to_iso)
      .take(1)
      .first
  end

  def previous_post
    BlogPost.all
      .order(:_valid_from)
      .and(:_valid_from, :is_less_than, valid_from.utc.to_iso)
      .reverse_order
      .take(1)
      .first
  end

  # Override auto-generated method +author+ from +CmsAttribute+.
  def author
    author = self[:author] || 'root'

    if author.present?
      @author ||= Infopark::Crm::Contact.search(params: { login: author }).first
      @author ||= Infopark::Crm::Contact.search(params: { email: author }).first
    end
  end
end
