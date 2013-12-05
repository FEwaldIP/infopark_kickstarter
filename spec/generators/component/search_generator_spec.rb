require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/search/search_generator.rb'

describe Cms::Generators::Component::SearchGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    paths = {
      models: "#{destination_root}/app/models",
      layouts: "#{destination_root}/app/views/layouts",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{paths[:models]}/homepage.rb", 'w') { |f| f.write("class Homepage < Obj\n") }
    File.open("#{paths[:layouts]}/_main_navigation.html.haml", 'w') { |f| f.write("    .navbar-collapse.collapse\n") }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'search_page.rb' do
            contains 'cms_attribute :show_in_navigation, type: :boolean'
            contains 'cms_attribute :headline, type: :string'
            contains '  include Page'
          end

          file 'homepage.rb' do
            contains 'cms_attribute :search_page, type: :reference'
          end
        end

        directory 'views' do
          directory 'search_page' do
            file 'index.html.haml'
          end

          directory 'layouts' do
            file '_search.html.haml'
            file '_main_navigation.html.haml' do
              contains "      = render('layouts/search', search_page: homepage.search_page, query: params[:q])"
            end
          end
        end

        directory 'controllers' do
          file 'search_page_controller.rb'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_search_page'
          migration 'create_search_page_example'
        end
      end
    }
  end
end
