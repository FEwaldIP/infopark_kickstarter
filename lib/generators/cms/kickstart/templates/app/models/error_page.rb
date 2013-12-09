class ErrorPage < Page
  cms_attribute :headline, type: :string

  # Overrides method +show_in_navigation+ from +Page+.
  def show_in_navigation?
    false
  end
end
