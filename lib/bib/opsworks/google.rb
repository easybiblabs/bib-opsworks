require 'net/http'

module Bib
  module Opsworks
    class Google
      include Logging

      def publish_deployment(app_name, deploy_data, google_ident)
        google_params = prepare_publishing_data(app_name, deploy_data)

        label = "#{google_params['deployment[user]']}-#{google_params['deployment[revision]']}"
        query = "tid=#{google_ident}&ea=#{app_name}&el=#{label}"
        google_url = "http://www.google-analytics.com/collect?v=1&cid=555&t=event&ec=deployment&#{query}"
        url = URI.parse(google_url)

        request = Net::HTTP::Get.new(url.request_uri)
        log.debug('Google Analytics: sending data: ' + google_url)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = false
        resp = http.request(request)
        log.debug('Google Analytics Response: ' + resp.code + ' ' + resp.message)
        resp.is_a? Net::HTTPSuccess
      end

      def prepare_publishing_data(app_name, deploy_data)
        scm_revision = deploy_data['scm']['revision']

        deployment_user = if deploy_data['deploying_user'].nil? || deploy_data['deploying_user'].empty?
                            'opsworks'
                          else
                            deploy_data['deploying_user'].split('/')[1]
                          end

        google_params = {}
        {
          app_name: app_name,
          user: deployment_user,
          revision: scm_revision
        }.each do |k, v|
          google_params["deployment[#{k}]"] = v unless v.nil? || v == ''
        end
        google_params
      end
    end
  end
end
