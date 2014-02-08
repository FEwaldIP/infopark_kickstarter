require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/deployment/opsworks/opsworks_generator'

describe Cms::Generators::Component::Deployment::OpsworksGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    config_path = "#{destination_root}/config"
    initializers_path = "#{config_path}/initializers"

    mkdir_p(initializers_path)

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{initializers_path}/rails_connector.rb", 'w')
  end

  it 'creates initializer file' do
    destination_root.should have_structure {
      directory 'config' do
        directory 'initializers' do
          file 'rails_connector.rb' do
            contains 'RailsConnector::Configuration.cache_path = "/tmp/cache/#{Rails.root.basename}"'
          end
        end

        file 'schedule.rb' do
          contains "set :output, 'log/cron.log'"
          contains "rake 'infopark:cache:gc'"
          contains "job_type :rake, 'cd :path && RAILS_ENV=:environment PATH=/usr/local/bin:/usr/bin:/bin /usr/local/bin/bundle exec rake :task --silent :output'"
          contains 'every 1.day do'
        end
      end

      directory 'deploy' do
        file 'after_restart.rb' do
          contains 'run "cd #{release_path} && bundle exec whenever --update-crontab myapp"'
        end

        file 'before_symlink.rb' do
          contains 'run "cd #{release_path} && bundle exec whenever --clear-crontab myapp"'
        end
      end

      file 'Gemfile' do
        contains 'gem "whenever", :require => false'
      end
    }
  end
end
