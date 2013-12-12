require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/accordion/accordion_generator.rb'

describe Cms::Generators::Widget::AccordionGenerator do
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
        directory 'assets' do
          directory 'javascripts' do
            directory 'editing' do
              file 'accordion_widget.js.coffee'
            end
          end
        end

        directory 'widgets' do
          directory 'accordion_widget' do
            directory 'views' do
              file 'show.html.haml'
              file 'thumbnail.html.haml'
              no_file 'edit.html.haml'
            end

            directory 'migrate' do
              migration 'create_accordion_widget'
            end
          end

          directory 'accordion_panel_widget' do
            directory 'views' do
              file 'show.html.haml'
              file 'thumbnail.html.haml'
              file 'edit.html.haml'
            end

            directory 'migrate' do
              migration 'create_accordion_panel_widget'
            end
          end
        end

        directory 'models' do
          file 'accordion_widget.rb' do
            contains 'class AccordionWidget < Widget'
            contains 'def valid_widget_classes_for'
          end

          file 'accordion_panel_widget.rb' do
            contains 'class AccordionPanelWidget < Widget'
          end
        end
      end
    }
  end
end
