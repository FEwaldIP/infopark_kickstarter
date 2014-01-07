class FormBuilder < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'FormBuilder',
      type: 'publication',
      title: 'Form Builder',
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
