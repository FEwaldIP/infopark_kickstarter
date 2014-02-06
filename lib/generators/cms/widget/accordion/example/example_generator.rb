module Cms
  module Generators
    module Widget
      module Accordion
        class ExampleGenerator < Cms::Generators::Widget::Example::Base
          source_root File.expand_path('../templates', __FILE__)

          def create_example
            migration_template('migration.rb', 'cms/migrate/accordion_widget_example.rb')
          rescue Rails::Generators::Error
          end

          notice!

          private

          def obj_class_name
            'AccordionWidget'
          end

          def panel_obj_class_name
            'AccordionPanelWidget'
          end

          def panel_attribute
            'panels'
          end
        end
      end
    end
  end
end
