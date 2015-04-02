require 'net/http'

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
        request.set_form_data(qafoo_params)

        log.debug('qafoo sending data: ' + qafoo_params.inspect)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        resp = http.request(request)
        log.debug('qafoo Response: ' + resp.code + ' ' + resp.message)
        resp.is_a? Net::HTTPSuccess
      end

      def prepare_publishing_data(app_name, deploy_data)
        scm_revision = deploy_data['scm']['revision']

        if deploy_data['deploying_user'].nil? || deploy_data['deploying_user'].empty?
          deployment_user = 'opsworks'
        else
          deployment_user = deploy_data['deploying_user'].split('/')[1]
        end

        name_text = "#{scm_revision} by #{deployment_user}"

        qafoo_params = {
          apiKey: qafoo_api_key,
          name: name_text,
          environment: app_name,
          type: 'deployment'
        }
        qafoo_params
      end
    end
  end
end
