module Cms
  module Generators
    class ObjGenerator < ::Rails::Generators::NamedBase
      include Migration

      source_root File.expand_path('../templates', __FILE__)

      def create_model
        template('model.rb', "app/models/#{class_name}.rb")
      end

      def create_views
        template('thumbnail.html.haml', "app/views/#{file_name}/thumbnail.html.haml")
      end

      def create_migration
        migration_template('migration.rb', "cms/migrate/#{file_name}.rb")
      end

      def notice
        if behavior == :invoke
          log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
        end
      end
    end
  end
end
