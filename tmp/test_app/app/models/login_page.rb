class LoginPage < Obj
  cms_attribute :headline, type: :string

  include Page

  def show_breadcrumbs?
    false
  end
end
