class AccordionWidgetExample < ::RailsConnector::Migration
  def up
    homepage = Obj.find_by_path('<%= example_cms_path %>')

    text_widget1_id = add_widget_to_widget_pool(homepage, {
      _obj_class: 'TextWidget',
      content: '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
    })

    text_widget2_id = add_widget_to_widget_pool(homepage, {
      _obj_class: 'TextWidget',
      content: '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
    })

    panel_widget1_id = add_widget_to_widget_pool(homepage, {
      _obj_class: '<%= panel_obj_class_name %>',
      headline: 'Duis aute irure dolor in reprehenderit',
      main_content: {
        'list' => [
          { widget: text_widget1_id },
        ]
      },
    })

    panel_widget2_id = add_widget_to_widget_pool(homepage, {
      _obj_class: '<%= panel_obj_class_name %>',
      headline: 'Excepteur sint occaecat cupidatat',
      main_content: {
        'list' => [
          { widget: text_widget2_id },
        ]
      },
    })

    add_widget(homepage, '<%= example_widget_attribute %>', {
      _obj_class: '<%= obj_class_name %>',
      panels: {
        'list' => [
          { widget: panel_widget1_id },
          { widget: panel_widget2_id },
        ]
      }
    })
  end

  private

  def add_widget_to_widget_pool(obj, widget_params)
    workspace_id = RailsConnector::Workspace.current.id
    obj_params = RailsConnector::CmsRestApi.get("workspaces/#{workspace_id}/objs/#{obj.id}")
    widget_id = RailsConnector::BasicObj.generate_widget_pool_id

    params = {}
    params['_widget_pool'] = { widget_id => widget_params }

    update_obj(obj_params['id'], params)

    widget_id
  end

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
