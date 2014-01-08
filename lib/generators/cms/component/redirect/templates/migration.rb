class Redirect < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'Redirect',
      type: 'publication',
      title: 'Redirect',
      attributes: [
        {
          name: 'redirect_link',
          type: :linklist,
          max_size: 1,
        },
      ]
    )
  end
end
