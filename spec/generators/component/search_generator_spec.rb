require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/search/search_generator.rb'

describe Cms::Generators::Component::SearchGenerator do
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
          file 'search_page.rb' do
            contains 'class SearchPage < Page'
          end
        end

        directory 'views' do
          directory 'search_page' do
            file 'index.html.haml'
            file 'edit.html.haml'
          end

          directory 'layouts' do
            file '_search.html.haml'
          end
        end

        directory 'controllers' do
          file 'search_page_controller.rb'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'search'
        end
      end
    }
  end
end
