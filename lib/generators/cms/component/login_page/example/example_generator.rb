module Cms
  module Generators
    module Component
      module LoginPage
        class ExampleGenerator < ::Rails::Generators::Base
          include Migration

          source_root File.expand_path('../templates', __FILE__)

          def create_example
            migration_template('migration.rb', 'cms/migrate/login_page_example.rb')
          end

          def copy_application_files
            directory('app')
          end

          def update_views
            append_file 'app/views/layouts/_footer.html.haml' do
              [
                '',
                '          - if page.homepage.present?',
                '            |',
                '',
                "            = render('layouts/login', login_page: page.homepage.login_page, current_user: current_user)",
              ].join("\n")
            end
          end

          def notice
            if behavior == :invoke
              log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
            end
          end
        end
      end
    end
  end
end
