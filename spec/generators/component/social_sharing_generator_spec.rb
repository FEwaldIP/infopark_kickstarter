require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/social_sharing/social_sharing_generator.rb'

describe Cms::Generators::Component::SocialSharingGenerator do
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
            file '_social_sharing.html.haml'

            directory 'social_sharing' do
              file '_facebook.html.haml'
              file '_google.html.haml'
              file '_linkedin.html.haml'
              file '_twitter.html.haml'
            end
          end
        end
      end
    }
  end
end
