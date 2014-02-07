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
          migration_template('migration.rb', 'cms/migrate/blog.rb')
        rescue Rails::Generators::Error
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
          directory('app')
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end
      end
    end
  end
end
