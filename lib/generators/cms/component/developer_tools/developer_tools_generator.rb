module Cms
  module Generators
    module Component
      class DeveloperToolsGenerator < ::Rails::Generators::Base
        def install_gems
          gem_group(:test, :development) do
            gem('pry-rails')
            gem('thin')
            gem('infopark_dashboard', '~> 0.0.3')
          end

          gem_group(:development) do
            gem('better_errors')
            gem('binding_of_caller')
          end

          Bundler.with_clean_env do
            run('bundle --quiet')
          end
        end

        def add_dashboard_route
          route("mount InfoparkDashboard::Engine => '/cms/dashboard' if Rails.env.development?")
        end
      end
    end
  end
end
