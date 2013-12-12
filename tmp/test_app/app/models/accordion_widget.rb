class AccordionWidget < Obj
  cms_attribute :panels, type: :widget

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  # include Page
  include Widget

  def valid_widget_classes_for(field_name)
    %w(AccordionPanelWidget)
  end
end