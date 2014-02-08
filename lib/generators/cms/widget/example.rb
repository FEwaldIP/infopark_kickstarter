module Cms
  module Generators
    module Widget
      module Example
        class Base < ::Rails::Generators::Base
          include Migration

          class_option :cms_path,
            type: :string,
            desc: 'CMS parent path where the example should be placed under'

          class_option :attribute,
            type: :string,
            desc: 'Widget attribute of the object class that holds the widget'

          def self.notice!
            define_method(:notice) do
              if behavior == :invoke
                log(:migration, 'Make sure to run "rake cms:migrate" to apply CMS changes')
              end
            end
          end

          protected

          def homepage_widget_attribute
            'main_content'
          end

          def example_cms_path
            options[:cms_path] || '/en'
          end

          def example_cms_path?
            example_cms_path
          end

          def example_widget_attribute
            options[:attribute] || homepage_widget_attribute
          end

          def example_widget_attribute?
            example_widget_attribute
          end
        end
      end
    end
  end
end
