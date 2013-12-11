module Cms
  module Generators
    module Component
      class RedirectGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          class_name = 'Redirect'

          Api::ObjClassGenerator.new(options, behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Redirect'
            model.description = 'A redirect page is a CMS page that forwards the ' \
              'visitor to another URL. The URL can be an internal or external link.'
            model.icon = 'refresh'
            model.page = true
            model.attributes = [
              {
                name: 'redirect_link',
                type: :linklist,
                title: 'Redirect link',
                max_size: 1,
              },
            ]
          end
        end

        def copy_app_directory
          directory('app', force: true)
        end
      end
    end
  end
end
