class <%= class_name %> < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: '<%= class_name %>',
      type: 'publication'
    )
  end
end
