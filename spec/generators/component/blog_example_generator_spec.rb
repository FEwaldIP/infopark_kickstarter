require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/blog/example/example_generator'

describe Cms::Generators::Component::Blog::ExampleGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'create files' do
    destination_root.should have_structure {
      directory 'cms' do
        directory 'migrate' do
          migration 'blog_example.rb'
        end
      end
    }
  end
end
