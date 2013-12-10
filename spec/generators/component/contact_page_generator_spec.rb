require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/contact_page/contact_page_generator.rb'

describe Cms::Generators::Component::ContactPageGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  arguments ['--cms_path=/website/en']

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
  end

  it 'creates file' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'contact_page.rb' do
            contains 'class ContactPage < Page'
          end
        end

        directory 'presenters' do
          file 'contact_page_presenter.rb'
        end

        directory 'services' do
          file 'contact_activity_service.rb'
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'en.contact_page.yml'
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_contact_page'
        end
      end
    }
  end
end
