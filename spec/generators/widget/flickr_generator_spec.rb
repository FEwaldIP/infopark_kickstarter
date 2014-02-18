require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/flickr/flickr_generator.rb'

describe Cms::Generators::Widget::FlickrGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'assets' do
          directory 'stylesheets' do
            directory 'application' do
              file 'flickr_widget.css'
            end
          end
        end

        directory 'models' do
          file 'flickr_widget.rb' do
            contains 'class FlickrWidget < Widget'
          end
        end

        directory 'widgets' do
          directory 'flickr_widget' do
            directory 'views' do
              file 'show.html.haml'
              file 'edit.html.haml'
              file 'thumbnail.html.haml'
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'flickr_widget'
        end
      end
    }
  end
end
