module Cms
  module Generators
    module Component
      module Tracking
        class GoogleAnalyticsGenerator < ::Rails::Generators::Base
          source_root File.expand_path('../templates', __FILE__)

          def copy_app_directory
            directory('app')
          end

          def insert_google_analytics
            file = 'app/views/layouts/application.html.haml'
            insert_point = "    = rails_connector_after_content_tags"

            data = []

            data << "    = render('layouts/google_analytics', tracking_id: 'UA-XXXX-Y', anonymize: true)"
            data << "\n"

            data = data.join("\n")

            insert_into_file(file, data, before: insert_point)
          end
        end
      end
    end
  end
end
