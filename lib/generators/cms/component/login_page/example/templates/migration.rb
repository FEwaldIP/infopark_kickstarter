class LoginPageExample < ::RailsConnector::Migration
  def up
    configuration_path = '/en/_configuration'

    login_page = Obj.create(
      _path: "#{configuration_path}/login",
      _obj_class: 'LoginPage',
      headline: 'Log in'
    )

    reset_password_page = Obj.create(
      _path: "#{configuration_path}/reset-password",
      _obj_class: 'ResetPasswordPage',
      headline: 'Reset Password'
    )

    attributes = get_obj_class('Homepage')['attributes']

    attributes << {
      name: 'login_page',
      type: :reference,
      title: 'Login Page',
    }

    attributes << {
      name: 'reset_password_page',
      type: :reference,
      title: 'Reset Password Page',
    }

    update_obj_class('Homepage', attributes: attributes)

    obj = Obj.find_by_path('/en')
    obj.update(
      login_page: login_page['id'],
      reset_password_page: reset_password_page['id'],
    )
  end
end
