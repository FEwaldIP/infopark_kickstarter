require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/model/model_generator'

describe Cms::Generators::ModelGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../tmp/generators', __FILE__)
  arguments [
    'news',
    '--title=Test News Title',
    '--description=Test News Description',
    '--type=generic',
    '--attributes=foo:html', 'bar:enum',
    '--mandatory_attributes=foo', 'bar',
    '--preset_attributes=foo:f', 'bar:b',
    '--page',
  ]

  before do
    prepare_destination
    run_generator
  end

  it 'generates model files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'news.rb' do
            contains 'class News < Page'
          end
        end

        directory 'views' do
          directory 'news' do
            file 'thumbnail.html.haml' do
              contains 'Test News Title'
              contains 'Test News Description'
            end
          end
        end
      end

      directory 'cms' do
        directory 'migrate' do
          migration 'create_news' do
            contains "name: 'News'"
            contains "title: 'Test News Title'"
            contains "type: 'generic'"
            contains '{:name=>"foo", :type=>"html"}'
            contains '{:name=>"bar", :type=>"enum"}'
            contains 'mandatory_attributes: ["foo", "bar"]'
            contains 'preset_attributes: {"foo"=>"f", "bar"=>"b"}'
          end
        end
      end
    }
  end
end
