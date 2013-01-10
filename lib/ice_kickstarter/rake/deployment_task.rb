require 'rake'
require 'rake/tasklib'

require 'ice_kickstarter/rake/credential_helper'

module IceKickstarter
  module Rake
    class DeploymentTask < ::Rake::TaskLib
      include CredentialHelper

      def initialize
        namespace :cms do
          namespace :deploy do
            desc 'Deploys to live cloud'
            task :live do
              live
            end

            desc 'Get deployment status for last deployment or given deployment id'
            task :status, [:id] do |_, args|
              args.with_defaults(:id => 'current')

              status(args[:id])
            end
          end
        end
      end

      private

      def status(id)
        sh "curl -X GET #{url}/deployments/#{id}?token=#{api_key}", :verbose => true

        puts
      end

      def live
        sh 'git fetch', :verbose => true

        if %x(git rev-parse origin/master).strip == %x(git rev-parse origin/deploy).strip
          sh "curl -X POST #{url}/deployments?token=#{api_key}", :verbose => true

          puts
        else
          sh 'rake assets:precompile && rake assets:clean'
          sh 'git push origin origin/master:deploy', :verbose => true
        end
      end
    end
  end
end