module Cms
  module Generators
    module Component
      module Blog
        class ExampleGenerator < ::Rails::Generators::Base
          include Migration

          source_root File.expand_path('../templates', __FILE__)

          def create_example
            migration_template('migration.rb', 'cms/migrate/blog_example.rb')
          end
        end
      end
    end
  end
end
