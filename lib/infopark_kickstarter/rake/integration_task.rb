require 'rake'
require 'rake/tasklib'

require 'infopark_kickstarter/rake/configuration_helper'

module InfoparkKickstarter
  module Rake
    class IntegrationTask < ::Rake::TaskLib
      def initialize
        namespace :test do
          desc 'Run Kickstarter Integration Tests'
          task :integration do
            prepare_directory
            create_configuration_files
            create_application
            call_generators
            run_tests
          end
        end
      end

      private

      def prepare_directory
        rm_rf(app_path)
        mkdir_p(config_path)

        puts 'prepared directory...'
      end

      def create_configuration_files
        ConfigurationHelper.new(local_configuration_file, :cms, "#{config_path}/rails_connector.yml").write
        ConfigurationHelper.new(local_configuration_file, :crm, "#{config_path}/custom_cloud.yml").write
        ConfigurationHelper.new(local_configuration_file, :deploy, "#{config_path}/deploy.yml").write

        puts 'created configuration files...'
      end

      def create_application
        Bundler.with_clean_env do
          sh "rails new #{app_path} --skip-test-unit --skip-active-record --skip-bundle --template template.rb"

          sh 'bundle --quiet'

          sh "cd #{app_path} && bundle exec rake cms:migrate"
        end
      end

      def call_generators
        Bundler.with_clean_env do
          sh "cd #{app_path} && bundle exec rails generate cms:component:error_tracking --provider=airbrake"
          sh "cd #{app_path} && bundle exec rails generate cms:component:newrelic \"Test Website\""
          sh "cd #{app_path} && bundle exec rails generate cms:component:google_analytics"
          sh "cd #{app_path} && bundle exec rails generate cms:component:contact_page"
          sh "cd #{app_path} && bundle exec rails generate cms:component:language_switch"
          sh "cd #{app_path} && bundle exec rails generate cms:component:profile_page"
          sh "cd #{app_path} && bundle exec rails generate cms:component:blog --cms_path=/website/en"
          sh "cd #{app_path} && bundle exec rails generate cms:widget:google_maps --cms_path=/website/en/_boxes"
          sh "cd #{app_path} && bundle exec rails generate cms:widget:video --cms_path=/website/en/_boxes"

          sh "cd #{app_path} && bundle exec rake cms:migrate"
        end
      end

      def run_tests
        Bundler.with_clean_env do
          sh "cd #{app_path} && bundle exec rake spec"
        end
      end

      def app_path
        'tmp/test_app'
      end

      def config_path
        "#{app_path}/config"
      end

      def local_configuration_file
        file_locations = [
          'config/local.yml',
          "#{ENV["HOME"]}/.config/infopark/kickstarter.yml",
        ]

        file = file_locations.detect do |path|
          Pathname(path).exist?
        end

        unless file
          raise 'Local configuration file not found. Provide either "config/local.yml" or "~/.config/infopark/kickstarter.yml". See "config/local.yml.template" for an example.'
        end

        file
      end
    end
  end
end