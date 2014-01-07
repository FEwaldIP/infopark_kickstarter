module Cms
  module Generators
    module Widget
      module Column3
        class ExampleGenerator < Cms::Generators::Widget::Example::Base
          source_root File.expand_path('../../templates', __FILE__)

          def create_example
            migration_template('migration.rb', 'cms/migrate/column3_widget_example.rb')
          end

          notice!
        end
      end
    end
  end
end
