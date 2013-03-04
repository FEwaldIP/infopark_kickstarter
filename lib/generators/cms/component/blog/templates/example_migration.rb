class CreateBlogExample < ::RailsConnector::Migration
  def path
    '<%= homepage_path %>/blog'
  end

  def up
    create_obj(
      _path: path,
      _obj_class: '<%= blog_class_name %>',
      title: 'Blog',
      "<%= blog_entry_truncation_attribute_name %>" => '500',
      "<%= blog_eneable_facebook_button_attribute_name %>" => 'Yes',
      "<%= blog_eneable_twitter_button_attribute_name %>" => 'Yes'
    )

    create_obj(
      _path: "#{path}/entry-1",
      _obj_class: '<%= blog_entry_class_name %>',
      title: 'Nulla viverra metus vitae nunc iaculis dignissim',
      "<%= blog_entry_tags_attribute_name %>" => '"Fun", "Lorem"',
      "<%= blog_entry_author_id_attribute_name %>" => "",
      "<%= blog_entry_publication_date_attribute_name %>" => Time.now.strftime("%d.%m.%Y"),
      "<%= blog_entry_eneable_facebook_button_attribute_name %>" => 'Yes',
      "<%= blog_entry_eneable_twitter_button_attribute_name %>" => 'Yes'
    )

    create_obj(
      _path: "#{path}/entry-1/_boxes",
      _obj_class: 'Container',
    )


    create_obj(
      _path: "#{path}/entry-1/_boxes/text-1",
      _obj_class: 'BoxText',
      body: 'Quisque eget sem sit amet risus gravida commodo et sed neque. Morbi pellentesque
      urna ut sapien auctor mattis. Donec quis cursus enim. Pellentesque sodales, elit nec
      accumsan congue, orci velit commodo orci, vel luctus nisi mi vitae erat. Cras lacus urna,
      sagittis tristique placerat vel, consectetur id leo. Vestibulum in congue mauris. Donec
      volutpat nibh ut nunc hendrerit porta. Pellentesque habitant morbi tristique senectus et
      netus et malesuada fames ac turpis egestas. Aliquam in felis quis neque aliquet rutrum.
      Morbi interdum aliquet sollicitudin. Curabitur eget erat vitae risus aliquam ultricies ac
      ut leo. Praesent eget lectus lorem, eu luctus velit. Proin rhoncus consequat consectetur.',
    )

    create_obj(
      _path: "#{path}/entry-2",
      _obj_class: '<%= blog_entry_class_name %>',
      title: 'Curabitur eget erat vitae risus aliquam ultricies ac',
      "<%= blog_entry_tags_attribute_name %>" => '"General", "Lorem"',
      "<%= blog_entry_author_id_attribute_name %>" => "",
      "<%= blog_entry_publication_date_attribute_name %>" => Time.now.strftime("%d.%m.%Y"),
    )

    create_obj(
      _path: "#{path}/entry-2/_boxes",
      _obj_class: 'Container',
    )


    create_obj(
      _path: "#{path}/entry-2/_boxes/text-1",
      _obj_class: 'BoxText',
      body: 'Quisque eget sem sit amet risus gravida commodo et sed neque. Morbi pellentesque
      urna ut sapien auctor mattis. Donec quis cursus enim. Pellentesque sodales, elit nec
      accumsan congue, orci velit commodo orci, vel luctus nisi mi vitae erat. Cras lacus urna,
      sagittis tristique placerat vel, consectetur id leo. Vestibulum in congue mauris. Donec
      volutpat nibh ut nunc hendrerit porta. Pellentesque habitant morbi tristique senectus et
      netus et malesuada fames ac turpis egestas. Aliquam in felis quis neque aliquet rutrum.
      Morbi interdum aliquet sollicitudin. Curabitur eget erat vitae risus aliquam ultricies ac
      ut leo. Praesent eget lectus lorem, eu luctus velit. Proin rhoncus consequat consectetur.',
    )
  end
end