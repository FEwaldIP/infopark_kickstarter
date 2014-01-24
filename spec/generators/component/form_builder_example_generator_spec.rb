require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/form_builder/example/example_generator'

describe Cms::Generators::Component::FormBuilder::ExampleGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'form_builder_example'
        end
      end
    }
  end
end
