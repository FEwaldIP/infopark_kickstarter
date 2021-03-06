require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/form_builder/form_builder_generator.rb'

describe Cms::Generators::Component::FormBuilderGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'form_builder.rb' do
            contains 'class FormBuilder < Page'
          end
        end

        directory 'controllers' do
          file 'form_builder_controller.rb'
        end

        directory 'views' do
          directory 'form_builder' do
            file 'index.html.haml'
            file 'edit.html.haml'
            file 'thumbnail.html.haml'

            directory 'input' do
              file '_string.html.haml'
              file '_text.html.haml'
              file '_enum.html.haml'
              file '_multienum.html.haml'
            end
          end
        end

        directory 'presenters' do
          file 'form_presenter.rb'
        end

        directory 'services' do
          file 'activity_service.rb'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'form_builder'
        end
      end
    }
  end
end
