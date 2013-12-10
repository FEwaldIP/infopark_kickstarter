require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/slider/slider_generator.rb'

describe Cms::Generators::Widget::SliderGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'widgets' do
          directory 'slider_widget' do
            directory 'views' do
              file 'show.html.haml'
              file 'thumbnail.html.haml'
            end

            directory 'locales' do
              file 'en.slider_widget.yml'
            end

            directory 'migrate' do
              migration 'create_slider_widget'
            end
          end
        end

        directory 'models' do
          file 'slider_widget.rb' do
            contains 'class SliderWidget < Widget'
          end
        end
      end
    }
  end
end
