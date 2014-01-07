class YoutubeWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'YoutubeWidget',
      type: 'publication',
      title: 'Youtube',
      attributes: [
        {
          name: 'source',
          type: :linklist,
          title: 'Source',
          max_size: 1,
        },
        {
          name: 'max_width',
          type: :string,
          title: 'Max width',
        },
        {
          name: 'max_height',
          type: :string,
          title: 'Max height',
        },
      ],
      preset_attributes: {
        max_width: '660',
        max_height: '430',
      },
    )
  end
end
