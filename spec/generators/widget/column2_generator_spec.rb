require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/widget/column2/column2_generator.rb'

describe Cms::Generators::Widget::Column2Generator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'widgets' do
          directory 'column2_widget' do
            directory 'views' do
              file 'show.html.haml'
              file 'edit.html.haml'
              file 'thumbnail.html.haml' do
                contains '.editing-icon-2cols'
              end
            end
          end
        end

        directory 'models' do
          file 'column2_widget.rb' do
            contains 'class Column2Widget < Widget'
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'column2_widget'
        end
      end
    }
  end
end
