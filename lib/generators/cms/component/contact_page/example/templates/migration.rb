class ContactPageExample < ::RailsConnector::Migration
  def up
    Obj.create(
      _path: '/en/contact',
      _obj_class: 'ContactPage',
      headline: 'Contact'
    )
  end
end
