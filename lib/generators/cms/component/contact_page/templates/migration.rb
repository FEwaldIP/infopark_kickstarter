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
          title: 'Headline',
        },
        {
          name: 'crm_activity_type',
          type: :string,
          title: 'CRM Activity Type',
        },
      ]
    )
  end
end
