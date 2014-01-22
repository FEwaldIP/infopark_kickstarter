class DiagramWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'DiagramWidget',
      type: 'publication',
      title: 'Diagram',
      attributes: [
        {
          name: 'data',
          type: :string,
        },
      ],
    )
  end
end
