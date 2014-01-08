module Cms
  module Generators
    class WidgetGenerator < ::Rails::Generators::NamedBase
      include Migration

      source_root File.expand_path('../templates', __FILE__)

      def create_model
        template('model.rb', "app/models/#{file_name}.rb")
      end

      def create_migration
        migration_template('migration.rb', "cms/migrate/#{file_name}.rb")
      end

      def create_views
        path = "app/widgets/#{file_name}/views"

        template('show.html.haml', "#{path}/show.html.haml")
        template('edit.html.haml', "#{path}/edit.html.haml")
        template('thumbnail.html.haml', "#{path}/thumbnail.html.haml")
      end
    end
  end
end
