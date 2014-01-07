class VimeoWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'VimeoWidget',
      type: 'publication',
      title: 'Vimeo',
      attributes: [
        {
          name: 'source',
          type: :linklist,
          title: 'Source',
          max_size: 1,
        },
        {
          name: 'width',
          type: :string,
          title: 'Width',
        },
        {
          name: 'height',
          type: :string,
          title: 'Height',
        },
      ],
      preset_attributes: {
        width: '660',
        height: '430',
      }
    )
  end
end
