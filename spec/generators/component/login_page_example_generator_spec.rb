require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/login_page/example/example_generator.rb'

describe Cms::Generators::Component::LoginPage::ExampleGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    layouts_path = "#{destination_root}/app/views/layouts"

    mkdir_p(layouts_path)

    File.open("#{layouts_path}/_footer.html.haml", 'w') { |file| file.write('') }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'views' do
          directory 'layouts' do
            file '_login.html.haml'

            file '_footer.html.haml' do
              contains '          - if page.homepage.present?'
              contains '            |'
              contains "            = render('layouts/login', login_page: page.homepage.login_page, current_user: current_user)"
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'login_page_example.rb'
        end
      end
    }
  end
end
