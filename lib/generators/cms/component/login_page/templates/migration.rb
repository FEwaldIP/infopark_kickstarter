class LoginPage < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'LoginPage',
      type: 'publication',
      title: 'Login',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
      ]
    )
  end
end
