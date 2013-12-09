class FormBuilder < Obj
  cms_attribute :headline, type: :string
  cms_attribute :crm_activity_type, type: :string

  include Page
end
