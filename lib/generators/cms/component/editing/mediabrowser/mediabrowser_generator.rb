module Cms
  module Generators
    module Component
      module Editing
        class MediabrowserGenerator < ::Rails::Generators::Base
          include Actions

          source_root File.expand_path('../templates', __FILE__)

          def add_routes
            routes = [
              "get 'mediabrowser', to: 'mediabrowser#index'",
              "get 'mediabrowser/inspector', to: 'mediabrowser#inspector'",
              "get 'mediabrowser/modal', to: 'mediabrowser#modal'",
            ]

            route routes.join("\n  ")
          end

          def create_common_files
            directory('app')
          end
        end
      end
    end
  end
end
