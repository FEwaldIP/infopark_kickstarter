module Cms
  module Generators
    module Component
      module ErrorTracking
        class AirbrakeGenerator < ::Rails::Generators::Base
          source_root File.expand_path('../templates', __FILE__)

          class_option :skip_deployment_notification,
            type: :boolean,
            default: false,
            desc: 'Skip to notify airbrake on new deployments.'

          def include_gemfile
            gem('airbrake')

            Bundler.with_clean_env do
              run('bundle --quiet')
            end
          end

          def create_initializer_file
            template('airbrake.rb', File.join('config/initializers', 'airbrake.rb'))
          end

          def add_deployment_notification
            unless options[:skip_deployment_notification]
              destination = 'deploy/after_restart.rb'

              unless File.exist?(destination)
                create_file(destination)
              end

              append_file(destination) do
                File.read(find_in_source_paths('after_restart.rb'))
              end
            end
          end
        end
      end
    end
  end
end
