module Cms
  module Generators
    module Widget
      class VideoGenerator < ::Rails::Generators::Base
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        def video_tools
          gem('projekktor-rails')

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def update_application_js
          data = []

          data << ''
          data << '//= require projekktor'

          data = data.join("\n")

          update_javascript_manifest(data)
        end

        def update_application_css
          data = []

          data << ''
          data << ' *= require projekktor'

          data = data.join("\n")

          update_stylesheet_manifest(data)
        end

        def create_migration
          Api::WidgetGenerator.new(options, behavior: behavior) do |widget|
            widget.name = obj_class_name
            widget.icon = 'video'
            widget.title = 'Video'
            widget.description = 'Displays a video player for the given video file.'
            widget.attributes = [
              {
                name: 'source',
                type: :reference,
                title: 'Source',
              },
              {
                name: 'poster',
                type: :reference,
                title: 'Poster',
              },
              {
                name: 'width',
                type: :string,
                title: 'Width',
                default: 660,
              },
              {
                name: 'height',
                type: :string,
                title: 'Height',
                default: 430,
              },
              {
                name: 'autoplay',
                type: :enum,
                title: 'Autoplay this video?',
                values: ['Yes', 'No'],
                default: 'No',
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

        private

        def obj_class_name
          'VideoWidget'
        end
      end
    end
  end
end
