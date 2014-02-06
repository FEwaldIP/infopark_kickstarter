module Cms
  module Generators
    module Component
      module Search
        class ExampleGenerator < ::Rails::Generators::Base
          include Migration

          source_root File.expand_path('../templates', __FILE__)

          def create_example
            migration_template('migration.rb', 'cms/migrate/search_example.rb')
          rescue Rails::Generators::Error
          end

          def extend_view
            file = 'app/views/layouts/_main_navigation.html.haml'
            insert_point = "    .navbar-collapse.collapse\n"

            data = []

            data << "        = render('layouts/search', search_page: homepage.search_page, query: params[:q])\n"
            data << ''

            data = data.join("\n")

            insert_into_file(file, data, after: insert_point)
          end

          def notice
            if behavior == :invoke
              log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
            end
          end
        end
      end
    end
  end
end
