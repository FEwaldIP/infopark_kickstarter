require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/obj/obj_generator'

describe Cms::Generators::ObjGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp/generators', __FILE__)
  arguments ['news']

  before do
    prepare_destination
    run_generator
  end

  it 'generates model files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'news.rb' do
            contains 'class News < Obj'
          end
        end

        directory 'views' do
          directory 'news' do
            file 'thumbnail.html.haml'
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'news' do
            contains "name: 'News'"
            contains "type: 'publication'"
          end
        end
      end
    }
  end
end
