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
        directory 'cells' do
          file 'social_sharing_cell.rb'

          directory 'social_sharing' do
            file 'show.html.haml'
            file 'facebook.html.haml'
            file 'google.html.haml'
            file 'linkedin.html.haml'
            file 'twitter.html.haml'
          end
        end
      end
    }
  end
end
