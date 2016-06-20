require 'net/http'
require 'bib/opsworks/logging'

module Bib
  module Opsworks
    class Qafoo
      include Logging

      def publish_deployment(app_name, deploy_data, qafoo_api_key)
        qafoo_params = prepare_publishing_data(app_name, deploy_data)
        qafoo_params['apiKey'] = qafoo_api_key

        qafoo_url = 'https://app.tideways.io/api/events'
        url = URI.parse(qafoo_url)
        request = Net::HTTP::Post.new(url.request_uri)
        request.body = qafoo_params.to_json

        log.debug('qafoo sending data: ' + qafoo_params.to_json)
        begin
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          resp = http.request(request)
        rescue SocketError => se
          log.info('Unable to publish deployment with tideways: ' + se.message)
          return false
        end
        log.debug('qafoo Response: ' + resp.code + ' ' + resp.message)
        resp.is_a? Net::HTTPSuccess
      end

      def prepare_publishing_data(app_name, deploy_data)
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
