require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/text_image/example/example_generator.rb'

describe Cms::Generators::Widget::TextImage::ExampleGenerator do
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
          migration 'text_image_widget_example'
        end
      end
    }
  end
end
