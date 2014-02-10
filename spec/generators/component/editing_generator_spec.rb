require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/editing/editing_generator'

describe Cms::Generators::Component::EditingGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)
  arguments ['--editor=redactor']

  before do
    # We are calling a sub generator, so we need to make sure to set the correct destination root for
    # the test. This is not done globally, as this is the only test, were the sub generator is called.
    require 'generators/cms/component/editing/redactor/redactor_generator'
    Cms::Generators::Component::Editing::RedactorGenerator.send(:include, TestDestinationRoot)
    require 'generators/cms/component/editing/mediabrowser/mediabrowser_generator'
    Cms::Generators::Component::Editing::MediabrowserGenerator.send(:include, TestDestinationRoot)

    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    javascripts_path = "#{destination_root}/app/assets/javascripts"
    stylesheets_path = "#{destination_root}/app/assets/stylesheets"
    environments_path = "#{destination_root}/config/environments"
    layouts_path = "#{destination_root}/app/views/layouts"
    config_path = "#{destination_root}/config"

    mkdir_p(javascripts_path)
    mkdir_p(stylesheets_path)
    mkdir_p(environments_path)
    mkdir_p(layouts_path)
    mkdir_p(config_path)

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{environments_path}/production.rb", 'a') { |f| f.write('Test::Application.configure do') }
    File.open("#{layouts_path}/application.html.haml", 'w') { |file| file.write("  %body{body_attributes(@obj)}\n") }
    File.open("#{config_path}/routes.rb", 'w') { |file| file.write('Dummy::Application.routes.draw do') }
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'assets' do
          directory 'fonts' do
            file 'editing_icons-webfont.eot'
            file 'editing_icons-webfont.ttf'
            file 'editing_icons-webfont.woff'
          end

          directory 'stylesheets' do
            directory 'editing' do
              file 'base.css.less'
              file 'mixins.less'
              file 'icons.css.less'
              file 'buttons.css.less'
              file 'base.css.less'
              file 'menubar.css.less'

              directory 'editors' do
                file 'string_editor.css.less'
                file 'text_editor.css.less'
                file 'linklist_editor.css.less'
                file 'reference_editor.css.less'
                file 'referencelist_editor.css.less'
              end
            end

            file 'editing.css'
          end

          directory 'javascripts' do
            directory 'editing' do
              file 'base.js.coffee'

              directory 'editors' do
                file 'string_editor.js.coffee'
                file 'text_editor.js.coffee'
                file 'linklist_editor.js.coffee'
                file 'reference_editor.js.coffee'
                file 'referencelist_editor.js.coffee'
                file 'enum_editor.js.coffee'
                file 'multienum_editor.js.coffee'
                file 'date_editor.js.coffee'
              end
            end

            file 'editing.js' do
              contains '//= require jquery.ui.sortable'
            end
          end
        end

        directory 'helpers' do
          file 'editing_helper.rb'
        end

        directory 'views' do
          directory 'layouts' do
            file '_menubar.html.haml'

            file 'application.html.haml' do
              contains "    = render('layouts/menubar', current_user: current_user)"
            end
          end
        end
      end

      directory 'config' do
        directory 'environments' do
          file 'production.rb' do
            contains 'config.assets.precompile += %w(editing.css editing.js)'
          end
        end
      end

      file 'Gemfile' do
        contains 'gem "jquery-ui-rails"'
      end
    }
  end
end
