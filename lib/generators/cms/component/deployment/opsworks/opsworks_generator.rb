module Cms
  module Generators
    module Component
      module Deployment
        class OpsworksGenerator < ::Rails::Generators::Base
          source_root File.expand_path('../templates', __FILE__)

          def include_gemfile
            gem('whenever', require: false)

            Bundler.with_clean_env do
              run('bundle --quiet')
            end
          end

          def append_configuration
            destination = File.join(destination_root, 'config', 'initializers', 'rails_connector.rb')

            append_file(destination) do
              File.read(find_in_source_paths('rails_connector.rb'))
            end
          end

          def create_schedule
            template('schedule.rb', 'config/schedule.rb')
          end

          def add_after_restart
            destination = 'deploy/after_restart.rb'

            unless File.exist?(destination)
              create_file(destination)
            end

            append_file(destination) do
              File.read(find_in_source_paths('after_restart.rb'))
            end
          end

          def add_before_symlink
            destination = 'deploy/before_symlink.rb'

            unless File.exist?(destination)
              create_file(destination)
            end

            append_file(destination) do
              File.read(find_in_source_paths('before_symlink.rb'))
            end
          end
        end
      end
    end
  end
end
