class VideoWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'VideoWidget',
      type: 'publication',
      title: 'Video',
      attributes: [
        {
          name: 'source',
          type: :reference,
          title: 'Source',
        },
        {
          name: 'poster',
          type: :reference,
          title: 'Poster',
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
        {
          name: 'autoplay',
          type: :enum,
          title: 'Autoplay',
          values: %w(Yes No),
        },
      ],
      preset_attributes: {
        width: 660,
        height: 430,
        autoplay: 'No',
      }
    )
  end
end
