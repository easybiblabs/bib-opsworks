require 'net/http'

module Bib
  module Opsworks
    class Google
      include Logging

      def publish_deployment(app_name, deploy_data, google_ident)
        
        scm_revision = deploy_data['scm']['revision']
        if deploy_data['deploying_user'].nil? || deploy_data['deploying_user'].empty?
            deployment_user = 'opsworks'
            else
            deployment_user = deploy_data['deploying_user'].split('/')[1]
        end


        label = "#{deployment_user}-#{scm_revision}"
        query = "tid=#{google_ident}&ea=#{app_name}&el=#{label}"
        google_url = "http://www.google-analytics.com/collect?v=1&cid=555&t=event&ec=deployment&#{query}"
        url = URI.parse(google_url)

        request = Net::HTTP::Get.new(url.request_uri)
        log.debug('Google sending data: ' + request.inspect)

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = false
        resp = http.request(request)
        log.debug('Google Response: ' + resp.code + ' ' + resp.message)
        resp.is_a? Net::HTTPSuccess
      end

      def prepare_publishing_data(app_name, deploy_data)
        deploy_data
      end
    end
  end
end
