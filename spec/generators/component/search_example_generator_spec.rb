require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/search/example/example_generator.rb'

describe Cms::Generators::Component::Search::ExampleGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    paths = {
      layouts: "#{destination_root}/app/views/layouts",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{paths[:layouts]}/_main_navigation.html.haml", 'w') { |f| f.write("    .navbar-collapse.collapse\n") }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'views' do
          directory 'layouts' do
            file '_main_navigation.html.haml' do
              contains "      = render('layouts/search', search_page: homepage.search_page, query: params[:q])"
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'search_example'
        end
      end
    }
  end
end
