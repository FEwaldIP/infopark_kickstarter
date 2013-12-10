require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/login_page/login_page_generator.rb'

describe Cms::Generators::Component::LoginPageGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    environments_path = "#{destination_root}/app"
    models_path = "#{environments_path}/models"
    layouts_path = "#{environments_path}/views/layouts"

    mkdir_p(environments_path)
    mkdir_p(models_path)
    mkdir_p(layouts_path)

    File.open("#{models_path}/homepage.rb", 'w') { |file| file.write("class Homepage < Page\n") }
    File.open("#{layouts_path}/_footer.html.haml", 'w') { |file| file.write('') }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'controllers' do
          file 'login_page_controller.rb'
          file 'reset_password_page_controller.rb'
        end

        directory 'models' do
          file 'login_page.rb' do
            contains 'class LoginPage < Page'
          end

          file 'reset_password_page.rb' do
            contains 'class ResetPasswordPage < Page'
          end
        end

        directory 'views' do
          directory 'login_page' do
            file 'index.html.haml'
          end

          directory 'reset_password_page' do
            file 'index.html.haml'
          end

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
    }
  end
end
