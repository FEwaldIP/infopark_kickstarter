module Cms
  module Generators
    module Component
      module ContactPageDescription
        def class_name
          'ContactPage'
        end

        def crm_activity_type_attribute_name
          'crm_activity_type'
        end

        def activity_type
          'contact-form'
        end
      end
    end
  end
end
