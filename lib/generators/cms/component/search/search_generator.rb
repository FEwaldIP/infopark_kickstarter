module Cms
  module Generators
    module Component
      class SearchGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths
        include Actions

        class_option :homepage_path,
          type: :string,
          default: nil,
          desc: 'Path to a CMS homepage, for which to enable search.'

        source_root File.expand_path('../templates', __FILE__)

        def extend_view
          file = 'app/views/layouts/_main_navigation.html.haml'
          insert_point = "    .navbar-collapse.collapse\n"

          data = []

          data << "        = render('layouts/search', search_page: homepage.search_page, query: params[:q])\n"
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def create_migration
          class_name = 'SearchPage'

          Api::ObjClassGenerator.new(options, behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Search'
            model.thumbnail = false
            model.page = true
            model.attributes = [
              {
                name: headline_attribute_name,
                type: :string,
                title: 'Headline',
              },
            ]
          end

          Rails::Generators.invoke('cms:controller', [class_name], behavior: behavior)

          migration_template('example_migration.rb', 'cms/migrate/create_search_page_example.rb')
        end

        def copy_app_directory
          directory('app', force: true)
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
          end
        end

        private

        alias_method :original_homepage_path, :homepage_path
        def homepage_path
          options[:homepage_path] || original_homepage_path
        end

        def headline_attribute_name
          'headline'
        end

        def search_page_attribute
          {
            name: 'search_page',
            type: :reference,
            title: 'Search Page',
          }
        end

        def class_name
          'SearchPage'
        end
      end
    end
  end
end
