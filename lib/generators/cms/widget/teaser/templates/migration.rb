class TeaserWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'TeaserWidget',
      type: 'publication',
      title: 'Teaser',
      attributes: [
        {
          name: 'headline',
          type: :string,
          title: 'Headline',
        },
        {
          name: 'content',
          type: :html,
          title: 'Content',
        },
        {
          name: 'link_to',
          type: :linklist,
          title: 'Link to',
          max_size: 1,
        },
      ]
    )
  end
end
