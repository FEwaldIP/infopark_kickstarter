module Cms
  module Generators
    module Component
      class FormBuilderGenerator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          Api::ObjClassGenerator.new(options, behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Form Builder'
            model.page = true
            model.attributes = [
              {
                name: title_attribute_name,
                type: :string,
                title: 'Headline',
              },
              {
                name: crm_activity_type_attribute_name,
                type: :string,
                title: 'CRM Activity Type',
              },
            ]
          end
        end

        def copy_app_directory
          directory('app', force: true)
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
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
