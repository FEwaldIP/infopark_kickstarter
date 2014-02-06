module Cms
  module Generators
    module Widget
      module Slider
        class ExampleGenerator < Cms::Generators::Widget::Example::Base
          source_root File.expand_path('../templates', __FILE__)

          def create_example
            migration_template('migration.rb', 'cms/migrate/slider_widget_example.rb')
          rescue Rails::Generators::Error
          end

          notice!
        end
      end
    end
  end
end
