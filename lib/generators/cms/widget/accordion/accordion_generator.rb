module Cms
  module Generators
    module Widget
      class AccordionGenerator < ::Rails::Generators::Base
        include BasePaths
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          Api::WidgetGenerator.new(behavior: behavior) do |widget|
            widget.name = 'AccordionWidget'
            widget.icon = 'puzzle'
            widget.edit_view = false
            widget.description = 'Displays collapsible content panels for presenting information in a limited amount of space.'
            widget.attributes = [
              {
                name: 'panels',
                type: :widget,
                title: 'Panels'
              },
            ]
          end
        end

        def add_widget_classes_callback
          file = 'app/models/accordion_widget.rb'
          insert_point = /^end[\n]*$/

          data = []
          data << ''
          data << '  def valid_widget_classes_for(field_name)'
          data << '    if field_name == \'panels\''
          data << '      %w(AccordionPanelWidget)'
          data << '    else'
          data << '      super(field_name)'
          data << '    end'
          data << '  end'
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, before: insert_point)
        end

        private

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
          end
        end
      end
    end
  end
end
