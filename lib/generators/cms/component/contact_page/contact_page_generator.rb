module Cms
  module Generators
    module Component
      class ContactPageGenerator < ::Rails::Generators::Base
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          migration_template('migration.rb', 'cms/migrate/contact_page.rb')
        rescue Rails::Generators::Error
        end

        def copy_app_directory
          directory('app')
        end

        def remove_custom_type
          if behavior == :revoke
            activity_type = 'contact-form'

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
      end
    end
  end
end
