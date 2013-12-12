require 'spec_helper'

require 'generator_spec/test_case'
require 'rails/generators/test_case'
require 'generators/cms/widget/accordion/accordion_generator.rb'

describe Cms::Generators::Widget::AccordionGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--example']

  before do
    prepare_destination
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'widgets' do
          directory 'accordion_widget' do
            directory 'views' do
              file 'thumbnail.html.haml'
              no_file 'edit.html.haml'

              file 'show.html.haml' do
                contains "class: 'accordion'"
              end
            end

            directory 'locales' do
              file 'en.accordion_widget.yml'
            end

            directory 'migrate' do
              migration 'create_accordion_widget'
            end
          end
        end

        directory 'models' do
          file 'accordion_widget.rb' do
            contains 'cms_attribute :panels, type: :widget'
            contains 'include Widget'
            contains 'def valid_widget_classes_for'
          end
        end
      end
    }
  end
end
