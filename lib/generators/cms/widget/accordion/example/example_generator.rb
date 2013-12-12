module Cms
  module Generators
    module Widget
      module Accordion
        class ExampleGenerator < Cms::Generators::Widget::Example::Base
          include Migration

          source_root File.expand_path('../../templates', __FILE__)

          def create_example
            example_migration_template(obj_class_name.underscore)
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
