module Cms
  module Generators
    module Widget
      class AccordionGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          Api::WidgetGenerator.new(behavior: behavior) do |widget|
            widget.name = 'AccordionWidget'
            widget.icon = 'list'
            widget.edit_view = false
            widget.title = 'Accordion'
            widget.description = 'Displays collapsible content panels for.'
            widget.attributes = [
              {
                name: 'panels',
                type: :widget,
                title: 'Panels'
              },
            ]
          end

          Api::WidgetGenerator.new(behavior: behavior) do |widget|
            widget.name = 'AccordionPanelWidget'
            widget.icon = '1col'
            widget.title = 'Accordion Panel'
            widget.description = 'Displays a collapsible content panel inside an accordion widget.'
            widget.attributes = [
              {
                name: 'headline',
                type: :string,
                title: 'Headline',
              },
              {
                name: 'main_content',
                type: :widget,
                title: 'Main Content'
              },
            ]
          end

          directory('app', force: true)
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
