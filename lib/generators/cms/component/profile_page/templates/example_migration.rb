class CreateProfilePageExample < ::RailsConnector::Migration
  def up
    path = '<%= cms_path %>/profile'

    create_obj(
      _path: path,
      _obj_class: '<%= obj_class_name %>',
      headline: 'Profile'
    )
  end
end
