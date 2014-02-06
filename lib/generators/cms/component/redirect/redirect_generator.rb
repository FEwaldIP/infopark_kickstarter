module Cms
  module Generators
    module Component
      class RedirectGenerator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          migration_template('migration.rb', 'cms/migrate/redirect.rb')
        rescue Rails::Generators::Error
        end

        def copy_app_directory
          directory('app')
        end
      end
    end
  end
end
