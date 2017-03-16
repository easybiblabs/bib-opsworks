require 'httparty'
require 'hipchat'
require 'bib/opsworks/logging'

module Bib
  module Opsworks
    class HipChat
      include Logging

      def publish_deployment(app_name, deploy_data, api_token, room)
        params = prepare_data(app_name, deploy_data)

        log.debug("HipChat Token: #{api_token}, Room: #{room}")

        begin
          client = ::HipChat::Client.new(api_token, api_version: 'v2')
          client[room].send('', "Deployment: #{params['name']} to #{params['environment']}", color: 'green')
        rescue StandardError => e
          log.error("Failed to publish deployment to HipChat: #{e}")
        end
      end

      def prepare_data(app_name, deploy_data)
        scm_revision = deploy_data['scm']['revision']

        deployment_user = if deploy_data['deploying_user'].nil? || deploy_data['deploying_user'].empty?
                            'opsworks'
                          else
                            deploy_data['deploying_user'].split('/')[1]
                          end

        name_text = "#{scm_revision} by #{deployment_user}"

        qafoo_params = {}
        qafoo_params['name'] = name_text
        qafoo_params['environment'] = app_name
        qafoo_params['type'] = 'release'
        qafoo_params
      end
    end
  end
end
