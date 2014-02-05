require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/deployment/deployment_generator'

describe Cms::Generators::Component::DeploymentGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--provider=opsworks']

  before do
    prepare_destination
    run_generator
  end
end
