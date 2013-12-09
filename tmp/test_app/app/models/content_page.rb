class ContentPage < Page
  cms_attribute :headline, type: :string
  cms_attribute :main_content, type: :widget
  cms_attribute :sidebar_content, type: :widget
end
