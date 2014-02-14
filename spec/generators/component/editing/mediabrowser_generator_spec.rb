require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/editing/mediabrowser/mediabrowser_generator'

describe Cms::Generators::Component::Editing::MediabrowserGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    config_path = "#{destination_root}/config"

    mkdir_p(config_path)

    File.open("#{config_path}/routes.rb", 'w') { |file| file.write('Dummy::Application.routes.draw do') }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'assets' do
          directory 'stylesheets' do
            directory 'editing' do
              file 'mediabrowser.css'
            end
          end

          directory 'javascripts' do
            directory 'editing' do
              directory 'jquery_additions' do
                file 'jquery_center.js.coffee'
                file 'jquery_formatter.js.coffee'
              end

              directory 'mediabrowser' do
                file 'inspector.js.coffee'
                file 'mediabrowser.js.coffee'
                file 'uploader.js.coffee'
              end
            end
          end
        end

        directory 'views' do
          directory 'layouts' do
            directory 'mediabrowser' do
              file 'inspector.html.haml'
            end
          end

          directory 'mediabrowser' do
            file '_buttons.html.haml'
            file '_header.html.haml'
            file 'modal.html.haml'

            directory 'thumbnails' do
              file 'blog_post.html.haml'
              file 'image.html.haml'
              file 'error_page.html.haml'
            end
          end

          directory 'obj' do
            file 'edit.html.haml'
          end
        end

        directory 'controllers' do
          file 'mediabrowser_controller.rb'
        end
      end

      directory 'config' do
        file 'routes.rb' do
          contains "get 'mediabrowser', to: 'mediabrowser#index'"
          contains "get 'mediabrowser/inspector', to: 'mediabrowser#inspector'"
          contains "get 'mediabrowser/modal', to: 'mediabrowser#modal'"
        end
      end
    }
  end
end
