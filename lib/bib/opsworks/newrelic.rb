
module Bib
  module Opsworks
    class Newrelic

      def publish_deployment(app_name, deploy_data, newrelic_api_key)

        newrelic_body = prepare_publishing_data(app_name, deploy_data)

        newrelic_url = "https://rpm.newrelic.com/deployments.xml"
        url = URI.parse(newrelic_url)
        request = Net::HTTP::Post.new(url.request_uri)
        request.add_field('X-License-Key', newrelic_api_key)
        request.body = newrelic_body
        resp = Net::HTTP.new(url.host, url.port).start do |http|
            http.request(request)
        end

        case resp
        when Net::HTTPOK
          return true
        else
          return false
        end

      end

      def prepare_publishing_data(app_name, deploy_data)
        scm_revision = deploy_data["scm"]["revision"]

        if deploy_data["deploying_user"].nil? or deploy_data["deploying_user"].empty?
          deployment_user = "opsworks"
        else
          deployment_user = deploy_data["deploying_user"].split('/')[1]
        end

        newrelic_appid_body = "deployment[app_name]=#{app_name}"
        newrelic_user_body = "deployment[user]=#{deployment_user}"
        newrelic_revision_body = "deployment[revision]=#{scm_revision}"

        "#{newrelic_appid_body}&#{newrelic_user_body}&=#{newrelic_revision_body}"
      end
    end
  end
end
