require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/error_tracking/airbrake/airbrake_generator'

describe Cms::Generators::Component::ErrorTracking::AirbrakeGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    File.open("#{destination_root}/Gemfile", 'w')
  end

  it 'creates initializer file' do
    destination_root.should have_structure {
      directory 'config' do
        directory 'initializers' do
          file 'airbrake.rb' do
            contains "config.api_key = ENV['AIRBRAKE_API_KEY'] || ''"
            contains 'config.secure = true'
          end
        end
      end

      directory 'deploy' do
        file 'after_restart.rb' do
          contains 'run "bundle exec rake environment airbrake:deploy TO=#{new_resource.environment[\'RAILS_ENV\']}"'
        end
      end

      file 'Gemfile' do
        contains 'gem "airbrake"'
      end
    }
  end
end
