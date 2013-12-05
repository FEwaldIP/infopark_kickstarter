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
    footer_cell_path = "#{environments_path}/cells/footer"

    mkdir_p(environments_path)
    mkdir_p(models_path)
    mkdir_p(footer_cell_path)

    File.open("#{models_path}/homepage.rb", 'w') { |file| file.write("class Homepage < Obj\n  include Page") }
    File.open("#{footer_cell_path}/show.html.haml", 'w') { |file| file.write('') }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'cells' do
          directory 'footer' do
            file '_login.html.haml'
          end

          directory 'footer' do
            file 'show.html.haml' do
              contains "          = render('login', current_user: current_user)"
            end
          end
        end

        directory 'controllers' do
          file 'login_page_controller.rb'
          file 'reset_password_page_controller.rb'
        end

        directory 'models' do
          file 'login_page.rb' do
            contains 'cms_attribute :headline, type: :string'
          end

          file 'reset_password_page.rb' do
            contains 'cms_attribute :headline, type: :string'
          end

          file 'homepage.rb' do
            contains 'cms_attribute :login_page, type: :reference'
            contains 'cms_attribute :reset_password_page, type: :reference'
          end
        end

        directory 'views' do
          directory 'login_page' do
            file 'index.html.haml'
          end

          directory 'reset_password_page' do
            file 'index.html.haml'
          end
        end
      end
    }
  end
end
