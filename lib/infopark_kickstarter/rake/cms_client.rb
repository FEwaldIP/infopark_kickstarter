require 'net/http'
require 'json'

module InfoparkKickstarter
  module Rake
    class CmsClient
      def reset_cms
        uri = URI("#{url}/workspaces?tenant_name=#{tenant_name}&revision_id=#{revision_id}")
        request = Net::HTTP::Delete.new(uri.request_uri)
        send_request(request)
      end

      private

      def config
        @config ||= begin
          path = File.expand_path('../../../../config', __FILE__)
          file = File.join(path, 'rails_connector.yml')
          YAML.load_file(file)['cms_api']
        end
      end

      def tenant_name
        url.match(/\/\/(.*?)\./)[1]
      end

      def url
        config['url']
      end

      def login
        config['login']
      end

      def api_key
        config['api_key']
      end

      def revision_id
        uri = URI("#{url}/workspaces/published")
        request = Net::HTTP::Get.new(uri.request_uri)
        send_request(request)['revision_id']
      end

      def http
        @http ||= begin
          uri = URI(url)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          http
        end
      end

      def send_request(request)
        request.basic_auth(login, api_key)
        response = http.request(request)
        JSON.parse(response.body)
      end
    end
  end
end
