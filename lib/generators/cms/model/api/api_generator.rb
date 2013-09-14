module Cms
  module Generators
    module Model
      class ApiGenerator < ::Rails::Generators::NamedBase
        Rails::Generators.hide_namespace(self.namespace)
        include Actions
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        attr_accessor :name
        attr_accessor :title
        attr_accessor :type
        attr_accessor :attributes
        attr_accessor :preset_attributes
        attr_accessor :mandatory_attributes
        attr_accessor :migration_path
        attr_accessor :model_path
        attr_accessor :icon
        attr_accessor :page

        def initialize(config = {})
          yield self if block_given?

          super([name], {}, config)

          self.invoke_all
        end

        def create_model_file
          template('model.rb', File.join(model_path, "#{file_name}.rb"))
        end

        def handle_attributes
          attributes.each do |definition|
            name = definition[:name]
            type = definition[:type]
            default = definition.delete(:default)

            if default.present?
              preset_attributes[name] = default
            end

            case type.to_s
              when 'boolean'
                definition[:type] = :enum
                definition[:values] = ['Yes', 'No']
              when 'integer'
                definition[:type] = :string
            end
          end
        end

        def create_migration_file
          migration_template('migration.rb', File.join(migration_path, "create_#{file_name}.rb"))
        end

        def turn_model_into_page
          if page?
            path = File.join(model_path, "#{file_name}.rb")

            uncomment_lines(path, 'include Page')
          end
        end

        private

        def page?
          @page.nil? ? false : @page
        end

        def type
          @type ||= :publication
        end

        def attributes
          @attributes ||= []
        end

        def preset_attributes
          @preset_attributes ||= {}
        end

        def mandatory_attributes
          @mandatory_attributes ||= []
        end

        def migration_path
          @migration_path ||= 'cms/migrate'
        end

        def model_path
          @model_path ||= 'app/models'
        end
      end
    end
  end
end
