require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/widget/widget_generator'

describe Cms::Generators::WidgetGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp/generators', __FILE__)
  arguments ['news_widget']

  before do
    prepare_destination
    run_generator
  end

  it 'generates widget' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'news_widget.rb' do
            contains 'class NewsWidget < Widget'
          end
        end

        directory 'widgets' do
          directory 'news_widget' do
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
          migration 'news_widget'
        end
      end
    }
  end
end
