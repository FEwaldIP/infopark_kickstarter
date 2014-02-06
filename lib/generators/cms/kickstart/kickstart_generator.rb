require 'uri'

module Cms
  module Generators
    class KickstartGenerator < ::Rails::Generators::Base
      include Migration

      class_option :examples,
        type: :boolean,
        default: false,
        desc: 'Creates example content along with setting up your project.'

      source_root File.expand_path('../templates', __FILE__)

      def remove_index_html
        path = Rails.root + 'public/index.html'

        if File.exist?(path)
          remove_file(path)
        end
      end

      def remove_rails_image
        path = Rails.root + 'app/assets/images/rails.png'

        if File.exist?(path)
          remove_file(path)
        end
      end

      def install_gems
        gem('active_attr')
        gem('haml-rails')
        gem('utf8-cleaner')
        gem('infopark_crm_connector')

        gem_group(:assets) do
          gem('therubyracer', platforms: :ruby)
          gem('less-rails-bootstrap', '~> 3.0')
        end

        Bundler.with_clean_env do
          run('bundle --quiet')
        end
      end

      def remove_erb_layout
        path = Rails.root + 'app/views/layouts/application.html.erb'

        if File.exist?(path)
          remove_file(path)
        end
      end

      def update_application_configuration
        directory('lib')
        directory('config', force: true)
      end

      def extend_gitignore
        append_file('.gitignore', "config/rails_connector.yml\n")
        append_file('.gitignore', "config/custom_cloud.yml\n")
      end

      def create_structure_migration_file
        # TODO: remove special migration once the CMS tenant is properly reset after signup.
        migration_template('create_image.rb', 'cms/migrate/create_image')

        migration_template('migration.rb', 'cms/migrate/kickstart.rb')
        migration_template('create_structure.rb', 'cms/migrate/create_structure.rb')
      rescue Rails::Generators::Error
      end

      def override_application
        directory('app', force: true)
      end

      def add_initial_content
        Rails::Generators.invoke('cms:component:editing', ['--editor=redactor'], behavior: behavior)
        Rails::Generators.invoke('cms:component:developer_tools', [], behavior: behavior)
        Rails::Generators.invoke('cms:component:search', [], behavior: behavior)
        Rails::Generators.invoke('cms:component:search:example', [], behavior: behavior)
        Rails::Generators.invoke('cms:component:login_page', [], behavior: behavior)
        Rails::Generators.invoke('cms:component:login_page:example', [], behavior: behavior)
        Rails::Generators.invoke('cms:component:sitemap', [], behavior: behavior)

        unless examples?
          Rails::Generators.invoke('cms:widget:text', [], behavior: behavior)
          Rails::Generators.invoke('cms:widget:image', [], behavior: behavior)
          Rails::Generators.invoke('cms:widget:headline', [], behavior: behavior)
        end
      end

      def create_example_content
        if examples?
          Rails::Generators.invoke('cms:kickstart:example', [], behavior: behavior)
        end
      end

      private

      def examples?
        options[:examples]
      end
    end
  end
end
