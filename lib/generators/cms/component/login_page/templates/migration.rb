class LoginPageExample < ::RailsConnector::Migration
  def up
    login_page = create_obj(
      _path: '<%= configuration_path %>/login',
      _obj_class: '<%= login_obj_class_name %>',
      headline: 'Login'
    )

    reset_password_page = create_obj(
      _path: '<%= configuration_path %>/reset-password',
      _obj_class: '<%= reset_password_obj_class_name %>',
      headline: 'Reset Password'
    )

    attributes = get_obj_class('Homepage')['attributes']

    attributes << {
      name: '<%= login_page_attribute_name %>',
      type: :reference,
      title: 'Login Page',
    }

    attributes << {
      name: '<%= reset_password_page_attribute_name %>',
      type: :reference,
      title: 'Reset Password Page',
    }

    update_obj_class('Homepage', attributes: attributes)

    update_obj(
      Obj.find_by_path('<%= homepage_path %>').id,
      '<%= login_page_attribute_name %>' => login_page['id'],
      '<%= reset_password_page_attribute_name %>' => reset_password_page['id'],
    )
  end
end
