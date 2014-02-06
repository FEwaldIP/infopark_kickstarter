module Cms
  module Generators
    module Component
      module ContactPage
        class ExampleGenerator < ::Rails::Generators::Base
          include Migration

          source_root File.expand_path('../templates', __FILE__)

          def create_migration
            migration_template('migration.rb', 'cms/migrate/contact_page_example.rb')
          rescue Rails::Generators::Error
          end
        end
      end
    end
  end
end
