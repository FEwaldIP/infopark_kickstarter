class FlickrWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'FlickrWidget',
      type: 'publication',
      title: 'Flickr',
      attributes: [
        {:name=>"count", :type=>:enum, values: (1..10).to_a, :title=>"Count"},
        {:name=>"sort", :type=>:enum, values: ['random', 'latest'], :title=>"Sort"},
        {:name=>"layout", :type=>:enum, values: ['horizontal', 'verticle', 'not-styled'], :title=>"Layout"},
        {:name=>"size", :type=>:enum, values: ['square', 'thumbnail', 'medium'], :title=>"Size"},
        {:name=>"source", :type=>:string, :title=>"Source"},
        {:name=>"source_type", :type=>:enum, values: ['user', 'group', 'user_set', 'all_tag'], :title=>"Source Type"},
      ],
      preset_attributes: {},
      mandatory_attributes: nil
    )
  end
end
