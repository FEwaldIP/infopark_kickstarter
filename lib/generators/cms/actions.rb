module Cms
  module Generators
    module Actions
      def update_javascript_manifest(data)
        file = 'app/assets/javascripts/application.js'
        insert_point = "\n//= require_self"

        insert_into_file(file, data, before: insert_point)
      end

      def update_javascript_editing_manifest(data)
        file = 'app/assets/javascripts/editing.js'
        insert_point = "\n//= require_self"

        insert_into_file(file, data, before: insert_point)
      end

      def update_stylesheet_manifest(data)
        file = 'app/assets/stylesheets/application.css'
        insert_point = "\n *= require_self"

        insert_into_file(file, data, before: insert_point)
      end

      def update_stylesheet_editing_manifest(data)
        file = 'app/assets/stylesheets/editing.css'
        insert_point = "\n *= require_self"

        insert_into_file(file, data, before: insert_point)
      end
    end
  end
end
