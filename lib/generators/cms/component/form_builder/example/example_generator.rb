module Cms
  module Generators
    module Component
      module FormBuilder
        class ExampleGenerator < ::Rails::Generators::Base
          include Migration
          include BasePaths

          source_root File.expand_path('../templates', __FILE__)

          def create_example
            migration_template('migration.rb', 'cms/migrate/create_form_builder_example.rb')
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
