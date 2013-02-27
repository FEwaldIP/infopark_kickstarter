class Create<%= class_name %>Attribute < ::RailsConnector::Migration
  def up
    create_attribute(
      name: '<%= file_name %>',
      type: 'enum',
      title: '<%= title %>',
      values: ["Yes", "No"]
    )
  end
end