require 'spec_helper'

require 'generator_spec/test_case'
require 'generators/cms/component/blog/blog_generator'

describe Cms::Generators::Component::BlogGenerator do
  include GeneratorSpec::TestCase

  destination File.expand_path('../../../../tmp/generators', __FILE__)

  before do
    prepare_destination
    prepare_environments
    run_generator
  end

  def prepare_environments
    paths = {
      layout: "#{destination_root}/app/views/layouts",
      javascripts: "#{destination_root}/app/assets/javascripts",
    }

    paths.each do |_, path|
      mkdir_p(path)
    end

    File.open("#{destination_root}/Gemfile", 'w')
    File.open("#{paths[:layout]}/application.html.haml", 'w') { |f| f.write("%link{href: '/favicon.ico', rel: 'shortcut icon'}\n") }
    File.open("#{paths[:javascripts]}/editing.js", 'w') { |file| file.write("\n//= require_self") }
  end

  it 'create files' do
    destination_root.should have_structure {
      directory 'app' do
        directory 'models' do
          file 'blog.rb' do
            contains 'class Blog < Page'
          end

          file 'blog_post.rb' do
            contains 'class BlogPost < Page'
          end
        end

        directory 'views' do
          directory 'blog' do
            file 'index.html.haml'
            file 'index.atom.builder'
            file '_comment_count.html.haml'
            file '_discovery.html.haml'
            file '_latest_blog_posts.html.haml'
            file '_pagination.html.haml'
            file '_post.html.haml'
            file '_short_post.html.haml'
            file '_useful_links.html.haml'
          end

          directory 'blog_post' do
            file 'index.html.haml'
            file '_comments.html.haml'
            file '_gravatar.html.haml'
            file '_main_content.html.haml'
            file '_pagination.html.haml'
            file '_published_at.html.haml'
            file '_published_by.html.haml'
          end

          directory 'layouts' do
            file 'application.html.haml' do
              contains "    = render('blog/discovery', page: @obj)"
            end
          end
        end

        directory 'controllers' do
          file 'blog_controller.rb'
          file 'blog_post_controller.rb'
        end

        directory 'assets' do
          directory 'images' do
            file 'feed-icon.svg'
          end

          directory 'javascripts' do
            directory 'editing' do
              file 'blog.js.coffee'
            end
          end
        end
      end

      directory 'config' do
        directory 'locales' do
          file 'en.blog.yml'
        end
      end

      file 'Gemfile' do
        contains 'gem "gravatar_image_tag"'
        contains 'gem "momentjs-rails"'
      end
    }
  end
end
