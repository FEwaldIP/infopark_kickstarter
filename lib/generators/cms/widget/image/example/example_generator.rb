module Cms
  module Generators
    module Widget
      module Image
        class ExampleGenerator < Cms::Generators::Widget::Example::Base
          include Migration

          source_root File.expand_path('../templates', __FILE__)

          def create_example
            migration_template('migration.rb', 'cms/migrate/image_widget_example.rb')
          end

          notice!
        end
      end
    end
  end
end
