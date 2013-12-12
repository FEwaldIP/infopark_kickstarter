module Cms
  module Generators
    module Api
      class ObjClassGenerator < ::Rails::Generators::NamedBase
        Rails::Generators.hide_namespace(self.namespace)

        include Attributes
        include Migration

        source_root File.expand_path('../templates', __FILE__)

        attr_accessor :title
        attr_accessor :description
        attr_accessor :type
        attr_accessor :attributes
        attr_accessor :preset_attributes
        attr_accessor :mandatory_attributes
        attr_accessor :page
        attr_accessor :widget
        attr_accessor :thumbnail
        attr_accessor :edit
        attr_accessor :icon
        attr_accessor :migration

        def initialize(options = {}, config = {})
          yield self if block_given?

          super([name], options, config)

          self.invoke_all
        end

        def create_model
          Api::ModelGenerator.new(behavior: behavior) do |model|
            model.name = name
            model.attributes = attributes
            model.preset_attributes = preset_attributes
            model.mandatory_attributes = mandatory_attributes
            model.page = page
            model.widget = widget
          end
        end

        def create_migration
          if migration?
            transform_attributes!(attributes, preset_attributes)

            migration_template('migration.rb', "cms/migrate/create_#{file_name}.rb")
          end
        end

        def create_edit_view
          if edit?
            Api::EditViewGenerator.new(behavior: behavior) do |model|
              model.path = "app/views/#{file_name}"
              model.definitions = attributes
              model.object_variable = '@obj'
            end
          end
        end

        def create_thumbnail
          if thumbnail?
            Api::ThumbnailGenerator.new(behavior: behavior) do |thumbnail|
              thumbnail.name = name
              thumbnail.path = "app/views/#{file_name}"
              thumbnail.icon = icon
              thumbnail.title = title
              thumbnail.description = description
            end
          end
        end

        private

        def type
          @type ||= :publication
        end

        def migration?
          @migration.nil? ? true : @migration
        end

        def thumbnail?
          @thumbnail.nil? ? true : @thumbnail
        end

        def edit?
          @edit.nil? ? true : @edit
        end

        def icon
          @icon ||= 'box'
        end

        def attributes
          @attributes ||= []
        end

        def preset_attributes
          @preset_attributes ||= {}
        end
      end
    end
  end
end
