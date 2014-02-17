class ContactPage < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'ContactPage',
      type: 'publication',
      title: 'Contact',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
      ]
    )
  end
end
