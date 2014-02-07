module Cms
  module Generators
    module Component
      class DeploymentGenerator < ::Rails::Generators::Base
        SUPPORTED_PROVIDER = %w(opsworks)

        class_option :provider,
          type: :string,
          default: SUPPORTED_PROVIDER.first,
          desc: "Select what deployment provider to use. (#{SUPPORTED_PROVIDER.join(' | ')})"

        def validate_provider
          unless SUPPORTED_PROVIDER.include?(provider)
            puts 'Please choose a supported provider. See options for more details.'
            puts

            self.class.help(self)

            exit
          end
        end

        def run_generator_for_selected_provider
          Rails::Generators.invoke(
            "cms:component:deployment:#{provider}",
            [],
            behavior: behavior
          )
        end

        private

        def provider
          options[:provider]
        end
      end
    end
  end
end
