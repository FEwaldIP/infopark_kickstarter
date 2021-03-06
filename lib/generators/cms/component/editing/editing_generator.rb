module Cms
  module Generators
    module Component
      class EditingGenerator < ::Rails::Generators::Base
        include Actions

        source_root File.expand_path('../templates', __FILE__)

        SUPPORTED_EDITORS = %w(redactor)

        class_option :editor,
          type: :string,
          default: SUPPORTED_EDITORS.first,
          desc: "Select what html editor to use. (#{SUPPORTED_EDITORS.join(' | ')})"

        def validate_editor
          unless SUPPORTED_EDITORS.include?(editor)
            puts 'Please choose a supported editor. See options for more details.'
            puts

            self.class.help(self)

            exit
          end
        end

        def install_gems
          gem('bootstrap-datepicker-rails')
          gem('jquery-ui-rails')

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def create_common_files
          directory('app')
        end

        def update_production_environment
          data = []

          data << '# Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)'
          data << '  config.assets.precompile += %w(editing.css editing.js)'
          data << ''

          data = data.join("\n")

          environment(data, env: :production)

          log(:environment, 'production: config.assets.precompile += %w(editing.css editing.js)')
        end

        def add_menu_bar_to_layout
          file = 'app/views/layouts/application.html.haml'
          insert_point = "  %body{body_attributes(@obj)}\n"

          data = []

          data << "    = render('layouts/menubar', current_user: current_user)\n"
          data << ''

          data = data.join("\n")

          insert_into_file(file, data, after: insert_point)
        end

        def run_generator_for_selected_editor
          Rails::Generators.invoke("cms:component:editing:#{editor}", [], behavior: behavior)
          Rails::Generators.invoke('cms:component:editing:mediabrowser', [], behavior: behavior)
        end

        private

        def editor
          options[:editor]
        end
      end
    end
  end
end
