class TextWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'TextWidget',
      type: 'publication',
      title: 'Text',
      attributes: [
        {
          name: 'content',
          type: :html,
          title: 'Content',
        },
      ]
    )
  end
end
