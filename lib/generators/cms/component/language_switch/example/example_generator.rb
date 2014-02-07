module Cms
  module Generators
    module Component
      module LanguageSwitch
        class ExampleGenerator < ::Rails::Generators::Base
          source_root File.expand_path('../../templates', __FILE__)

          def extend_homepage
            append_file 'app/views/layouts/_main_navigation.html.haml' do
              [
                '',
                "        = render('layouts/languages', current: homepage, homepages: homepage.homepages)",
                '',
              ].join("\n")
            end
          end
        end
      end
    end
  end
end
