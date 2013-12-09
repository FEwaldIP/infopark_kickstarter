module Cms
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::NamedBase
      def generate_model
        invoke('cms:model', [file_name] + args)
      end

      def generate_controller
        invoke('cms:controller', [file_name])
      end
    end
  end
end
