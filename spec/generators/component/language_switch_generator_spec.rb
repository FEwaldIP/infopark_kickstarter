require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/language_switch/language_switch_generator.rb'

describe Cms::Generators::Component::LanguageSwitchGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
  end

  it 'creates files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'views' do
          directory 'layouts' do
            file '_languages.html.haml'
          end
        end
      end
    }
  end
end
