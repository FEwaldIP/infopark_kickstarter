class ProfilePageExample < ::RailsConnector::Migration
  def up
    Obj.create(
      _path: '/en/profile',
      _obj_class: 'ProfilePage',
      headline: 'Profile'
    )
  end
end
