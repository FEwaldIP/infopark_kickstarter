require_relative 'contact_page_description'

module Cms
  module Generators
    module Component
      class ContactPageGenerator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          Api::ObjClassGenerator.new(options, behavior: behavior) do |model|
            model.name = class_name
            model.title = 'Contact'
            model.page = true
            model.attributes = [
              {
                name: 'headline',
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

        def remove_custom_type
          if behavior == :revoke
            begin
              custom_type = Infopark::Crm::CustomType.find(activity_type)

              if yes?("Do you also want to delete the WebCRM activity type '#{activity_type}'?")
                custom_type.destroy

                say_status(:remove, "custom activity type #{activity_type}", :red)
              end
            rescue ActiveResource::ResourceNotFound
              say_status(:remove, "custom activity type #{activity_type} does not exist", :red)
            end
          end
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
          end
        end

        private

        def class_name
          'ContactPage'
        end

        def cms_path
          options[:cms_path]
        end

        include ContactPageDescription
      end
    end
  end
end
