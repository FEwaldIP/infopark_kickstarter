module Cms
  module Generators
    module Component
      class ProfilePageGenerator < ::Rails::Generators::Base
        include Migration
        include BasePaths

        source_root File.expand_path('../templates', __FILE__)

        def create_migration
          Api::ObjClassGenerator.new(options, behavior: behavior) do |model|
            model.name = obj_class_name
            model.title = 'Profile'
            model.description = 'The profile page displays a form where logged ' \
              'in users and editors can edit their profile.'
            model.icon = 'group'
            model.page = true
            model.attributes = [
              {
                name: 'headline',
                type: :string,
                title: 'Headline',
              },
            ]
          end
        end

        def copy_app_directory
          directory('app', force: true)
        end

        def notice
          if behavior == :invoke
            log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes.')
          end
        end

        private

        def obj_class_name
          'ProfilePage'
        end
      end
    end
  end
end
