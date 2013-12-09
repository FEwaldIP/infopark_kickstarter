module Cms
  module Generators
    module Component
      module FormBuilder
        class ExampleGenerator < ::Rails::Generators::Base
          include Migration

          source_root File.expand_path('../../templates', __FILE__)

          argument :cms_path,
            type: :string,
            default: nil,
            desc: 'CMS parent path where the example form should be placed under.',
            banner: 'LOCATION'

          def create_example
            migration_template('example_migration.rb', 'cms/migrate/create_form_builder_example.rb')
          end

          def notice
            if behavior == :invoke
              log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
            end
          end

          private

          def class_name
            'FormBuilder'
          end

          def crm_activity_type_attribute_name
            'crm_activity_type'
          end

          def activity_type
            'feedback-form'
          end

          def title_attribute_name
            'headline'
          end
        end
      end
    end
  end
end
