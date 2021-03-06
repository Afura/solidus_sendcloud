require 'faraday'

module SendcloudServices
   class Client
      # Config
      DEFAULT_OPEN_TIMEOUT = 60
      DEFAULT_TIMEOUT = 120
      SENDCLOUD_API = 'https://panel.sendcloud.sc/api/v2'

      # Resources
      PARCEL_RESOURCE= '/parcels'

      attr_reader :api_endpoint, :api_key, :api_secret, :content_type

      def initialize(api_key = nil, api_secret = nil)
         @api_endpoint     = SENDCLOUD_API
         @api_key          = api_key
         @api_secret       = api_secret
         @content_type     = {"Content-Type" => "application/json"} 
      end
      
      def get_parcels
         request(:get, PARCEL_RESOURCE)
      end

      def create_parcel(params)
         request(:post, PARCEL_RESOURCE, params)
      end

      def update_parcel(params)
         request(:put, PARCEL_RESOURCE, params)
      end

      def delete_parcel(id)
         request(:post, PARCEL_RESOURCE + id + '/delete')
      end

      private

      def request(method, resource, params = {})
         response = client.public_send(method, SENDCLOUD_API + resource, params, content_type)
         parsed_response = Oj.load(response.body)
       end
      
      def client
         @client ||= Faraday.new(SENDCLOUD_API) do |client|
            client.adapter Faraday.default_adapter
            client.request :url_encoded
            client.basic_auth(api_key, api_secret)
          end
      end
   end
end