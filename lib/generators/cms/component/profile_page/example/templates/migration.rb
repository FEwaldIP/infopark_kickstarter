class ProfilePageExample < ::RailsConnector::Migration
  def up
    create_obj(
      _path: '/en/profile',
      _obj_class: 'ProfilePage',
      headline: 'Profile'
    )
  end
end
