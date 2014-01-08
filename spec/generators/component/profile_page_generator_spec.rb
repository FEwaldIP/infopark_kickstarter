require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/profile_page/profile_page_generator.rb'

describe Cms::Generators::Component::ProfilePageGenerator do
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
          file 'profile_page.rb' do
            contains 'class ProfilePage < Page'
          end
        end

        directory 'views' do
          directory 'profile_page' do
            file 'index.html.haml'
            file 'edit.html.haml'
            file 'thumbnail.html.haml'
          end
        end

        directory 'presenters' do
          file 'profile_page_presenter.rb'
        end

        directory 'controllers' do
          file 'profile_page_controller.rb'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'profile_page'
        end
      end
    }
  end
end
