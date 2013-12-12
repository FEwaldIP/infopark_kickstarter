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

          directory('app', force: true)
          directory('spec')
        end

        def call_accordion_panel_generator
          Rails::Generators.invoke('cms:widget:accordion_panel', args, behavior: behavior)
        end

        def add_widget_classes_callback
          file = 'app/models/accordion_widget.rb'
          insert_point = /^end[\n]*$/

          data = []
          data << ''
          data << '  def valid_widget_classes_for(field_name)'
          data << '    %w(AccordionPanelWidget)'
          data << '  end'
          data << ''

          data = data.join("\n")

          if File.exist?(file)
            insert_into_file(file, data, before: insert_point)
          end
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
