class ResetPasswordPage < Page
  cms_attribute :headline, type: :string

  def show_breadcrumbs?
    false
  end
end
