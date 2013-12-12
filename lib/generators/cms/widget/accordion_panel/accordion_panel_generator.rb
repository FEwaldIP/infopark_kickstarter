module Cms
  module Generators
    module Widget
      class AccordionPanelGenerator < ::Rails::Generators::Base
        Rails::Generators.hide_namespace(self.namespace)

        include BasePaths
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        def create_widget
          Api::WidgetGenerator.new(behavior: behavior) do |widget|
            widget.name = 'AccordionPanelWidget'
            widget.icon = '1col'
            widget.description = 'Displays a collapsible content panel inside an accordion widget.'
            widget.attributes = [
              {
                name: 'headline',
                type: :string,
                title: 'Headline',
              },
              {
                name: 'content',
                type: :html,
                title: 'Content'
              },
            ]
          end

          directory('app', force: true)
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
