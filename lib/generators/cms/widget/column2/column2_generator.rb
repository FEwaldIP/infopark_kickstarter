module Cms
  module Generators
    module Widget
      class Column2Generator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          migration_template('migration.rb', 'cms/migrate/column2_widget.rb')

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
