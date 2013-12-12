class AccordionWidget < Widget
  def valid_widget_classes_for(field_name)
    %w(AccordionPanelWidget)
  end
end
