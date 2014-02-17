class LoginPageExample < ::RailsConnector::Migration
  def up
    configuration_path = '/en/_configuration'

    login_page = Obj.create(
      _path: "#{configuration_path}/login",
      _obj_class: 'LoginPage',
      headline: 'Log in'
    )

    attributes = get_obj_class('Homepage')['attributes']

    attributes << {
      name: 'login_page',
      type: :reference,
      title: 'Login Page',
    }

    update_obj_class('Homepage', attributes: attributes)

    obj = Obj.find_by_path('/en')
    obj.update(
      login_page: login_page['id']
    )
  end
end
