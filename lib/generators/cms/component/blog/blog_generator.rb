require_relative 'blog_description'

module Cms
  module Generators
    module Component
      class BlogGenerator < ::Rails::Generators::Base
        include Migration
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        def add_gems
          gem('gravatar_image_tag')
          gem('momentjs-rails')

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def add_javascript_directives
          data = []

          data << ''
          data << '//= require moment'

          data = data.join("\n")

          update_javascript_editing_manifest(data)
        end

        def create_migration
          Api::ObjClassGenerator.new(options, behavior: behavior) do |model|
            model.name = blog_class_name
            model.title = 'Blog'
            model.page = true
            model.attributes = [
              {
                name: 'headline',
                type: :string,
                title: 'Headline',
              },
              {
                name: blog_disqus_shortname_attribute_name,
                type: :string,
                title: 'Disqus Shortname',
              },
              {
                name: blog_description_attribute_name,
                type: :string,
                title: 'Description',
              },
            ]
          end

          Api::ObjClassGenerator.new(options, behavior: behavior) do |model|
            model.name = blog_post_class_name
            model.title = 'Blog Post'
            model.thumbnail = false
            model.page = true
            model.attributes = [
              {
                name: 'headline',
                type: :string,
                title: 'Headline',
              },
              {
                name: blog_post_author_id_attribute_name,
                type: :string,
                title: 'Author ID',
              },
              {
                name: blog_post_author_name_attribute_name,
                type: :string,
                title: 'Author Name',
              },
              {
                name: widget_attribute_name,
                type: :widget,
                title: 'Main content',
              },
              {
                name: published_at_attribute_name,
                type: :date,
                title: 'Published at',
              },
            ]
          end

          Rails::Generators.invoke('cms:controller', [blog_post_class_name], behavior: behavior)
        end

        def add_discovery_link
          file = 'app/views/layouts/application.html.haml'
          insert_point = "%link{href: '/favicon.ico', rel: 'shortcut icon'}\n"

          data = []

          data << ''
          data << "    = render('blog/discovery', page: @obj)"
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def copy_app_directory
          directory('app', force: true)
          directory('config')
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end

        private

        include BlogDescription
      end
    end
  end
end
