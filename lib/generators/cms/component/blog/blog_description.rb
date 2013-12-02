module Cms
  module Generators
    module Component
      module BlogDescription
        def blog_class_name
          'Blog'
        end

        def blog_post_class_name
          'BlogPost'
        end

        def widget_attribute_name
          'main_content'
        end

        def blog_description_attribute_name
          'description'
        end

        def blog_post_author_id_attribute_name
          'author_id'
        end

        def blog_post_author_name_attribute_name
          'author_name'
        end

        def blog_disqus_shortname_attribute_name
          'disqus_shortname'
        end

        def published_at_attribute_name
          'published_at'
        end
      end
    end
  end
end
