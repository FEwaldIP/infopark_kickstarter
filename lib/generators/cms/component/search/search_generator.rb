module Cms
  module Generators
    module Component
      class SearchGenerator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          migration_template('migration.rb', 'cms/migrate/search.rb')
        end

        def copy_app_directory
          directory('app')
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
