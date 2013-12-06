module Cms
  module Generators
    module Component
      module SocialSharing
        class ExampleGenerator < ::Rails::Generators::Base
          def insert_share_code
            file = 'app/views/layouts/application.html.haml'
            insert_point = "      = render('layouts/footer', page: @obj)"

            data = []

            data << "      = render('layouts/social_sharing', url: cms_url(@obj))\n"
            data << ''

            data = data.join("\n")

            insert_into_file(file, data, before: insert_point)
          end
        end
      end
    end
  end
end
