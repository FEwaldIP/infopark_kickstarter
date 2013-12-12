class CreateAccordionWidgetExample < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path('<%= example_cms_path %>')

    widget = add_widget(homepage, '<%= example_widget_attribute %>', {
      _obj_class: '<%= obj_class_name %>'
    })

    widget = Obj.find(widget['id'])

    add_widget(widget, '<%= panel_attribute %>', {
      _obj_class: '<%= panel_obj_class_name %>',
      headline: 'Panel 1',
    })

    add_widget(widget, '<%= panel_attribute %>', {
      _obj_class: '<%= panel_obj_class_name %>',
      headline: 'Panel 2',
    })
  end

  private

  def add_widget(obj, attribute, widget_params)
    workspace_id = RailsConnector::Workspace.current.id
    obj_params = RailsConnector::CmsRestApi.get("workspaces/#{workspace_id}/objs/#{obj.id}")
    widget_id = RailsConnector::BasicObj.generate_widget_pool_id

    params = {}
    params['_widget_pool'] = { widget_id => widget_params }
    params[attribute] = obj_params[attribute] || {}
    params[attribute]['list'] ||= []
    params[attribute]['list'] << { widget: widget_id }

    update_obj(obj_params['id'], params)
  end
end
