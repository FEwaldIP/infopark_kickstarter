class CreateAccordionWidgetExample < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path("<%= example_cms_path %>")

    widget = add_widget(homepage, "<%= example_widget_attribute %>", {
      _obj_class: "<%= obj_class_name %>"
    })

    if defined?(AccordionPanelWidget)
      add_widget_panel(widget)
      add_widget_panel(widget)
    end
  end

  private

  def add_widget(obj, attribute, widget)
    widget.reverse_merge!({
      _path: "_widgets/#{obj.id}/#{SecureRandom.hex(8)}",
    })

    widget = create_obj(widget)

    revision_id = RailsConnector::Workspace.current.revision_id
    definition = RailsConnector::CmsRestApi.get("revisions/#{revision_id}/objs/#{obj.id}")

    widgets = definition[attribute] || {}
    widgets['layout'] ||= []
    widgets['layout'] << { widget: widget['id'] }

    update_obj(definition['id'], attribute => widgets)

    widget
  end

  def add_widget_panel(obj)
    add_widget(obj, "<%= panel_attribute %>", {
      _obj_class: "<%= panel_obj_class_name %>"
    })
  end
end
