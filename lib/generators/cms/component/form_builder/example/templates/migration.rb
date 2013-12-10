class CreateFormBuilderExample < ::RailsConnector::Migration
  def up
    create_obj(
      _path: '<%= homepage_path %>/feedback',
      _obj_class: 'FormBuilder',
      headline: 'Feedback',
      crm_activity_type: activity_type
    )

    setup_crm
  end

  def activity_type
    'feedback-form'
  end

  def setup_crm
    Infopark::Crm::CustomType.find(activity_type)
  rescue ActiveResource::ResourceNotFound
    custom_attributes = [
      { name: 'email', title: 'E-mail address', type: 'string' },
      { name: 'message', title: 'Message', type: 'text', max_length: 1000 }
    ]

    Infopark::Crm::CustomType.create(
      kind: 'Activity',
      name: activity_type,
      states: ['open', 'closed'],
      icon_css_class: 'omc_activity_23',
      custom_attributes: custom_attributes
    )
  end
end
