require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/redirect/redirect_generator.rb'

describe Cms::Generators::Component::RedirectGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    run_generator
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'redirect.rb' do
            contains 'class Redirect < Page'
          end
        end

        directory 'views' do
          directory 'redirect' do
            file 'index.html.haml'
            file 'edit.html.haml'
            file 'thumbnail.html.haml'
          end
        end

        directory 'controllers' do
          file 'redirect_controller.rb'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'redirect'
        end
      end
    }
  end
end
