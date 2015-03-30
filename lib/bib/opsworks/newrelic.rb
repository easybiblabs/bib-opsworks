require 'net/http'

module Bib
  module Opsworks
    class Newrelic
      include Logging

      def publish_deployment(app_name, deploy_data, newrelic_api_key)
        newrelic_params = prepare_publishing_data(app_name, deploy_data)

        newrelic_url = 'https://rpm.newrelic.com/deployments.xml'
        url = URI.parse(newrelic_url)
        request = Net::HTTP::Post.new(url.request_uri)
        request.add_field('X-Api-Key', newrelic_api_key)
        request.set_form_data(newrelic_params)

        log.debug('Newrelic sending data: ' + newrelic_params.inspect)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        resp = http.request(request)
        log.debug('Newrelic Response: ' + resp.code + ' ' + resp.message)
        resp.is_a? Net::HTTPSuccess
      end

      def prepare_publishing_data(app_name, deploy_data)
        scm_revision = deploy_data['scm']['revision']

        if deploy_data['deploying_user'].nil? || deploy_data['deploying_user'].empty?
          deployment_user = 'opsworks'
        else
          deployment_user = deploy_data['deploying_user'].split('/')[1]
        end

        newrelic_params = {}
        {
          app_name: app_name,
          user: deployment_user,
          revision: scm_revision
        }.each do |k, v|
          newrelic_params["deployment[#{k}]"] = v unless v.nil? || v == ''
        end
        newrelic_params
      end
    end
  end
end
