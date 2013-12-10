module Cms
  module Generators
    module Attributes
      def transform_attributes!(attributes, preset_attributes)
        attributes.each do |definition|
          name = definition[:name]
          type = definition[:type]
          default = definition.delete(:default)

          if default.present?
            preset_attributes[name] = default
          end

          definition[:title] = definition[:name].humanize
        end
      end
    end
  end
end
