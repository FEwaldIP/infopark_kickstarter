module Cms
  module Generators
    module Component
      class BreadcrumbsGenerator < ::Rails::Generators::Base
        source_root File.expand_path('../templates', __FILE__)

        def extend_page_concern
          file = 'app/models/page.rb'

          data = [
            '  # By default pages display a breadcrumb navigation. Either add a',
            '  # boolean cms attribute +show_breadcrumbs+ or override the method directly',
            '  # in your page model.',
            '  def show_breadcrumbs?',
            '    true',
            '  end',
            '',
            '  # Returns all breadcrumb pages. A breadcrumb page must be a +Page+ and needs',
            '  # to allow to be displayed in the navigation. Both +Root+ and +Website+ are',
            '  # not pages, so only pages up to the homepage are displayed.',
            '  def breadcrumbs',
            '    list = ancestors.select { |obj| obj.respond_to?(:show_in_navigation?) && obj.show_in_navigation? }',
            '    list + [self]',
            '  end',
            "\n",
          ].join("\n")

          insert_point = "class Page < Obj\n"

          insert_into_file(file, data, after: insert_point)
        end

        def extend_layout
          file = 'app/views/layouts/application.html.haml'

          data = [
            '        .row',
            '          .col-md-12',
            "            = render('layouts/breadcrumbs', page: @obj)",
            "\n",
          ].join("\n")

          insert_point = "      .content\n"

          insert_into_file(file, data, after: insert_point)
        end

        def copy_app_directory
          directory('app')
        end
      end
    end
  end
end
