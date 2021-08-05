require 'faraday'
require 'httparty'

module SendcloudServices
   class PartyClient
      include HTTParty
      format :json
      base_uri 'https://panel.sendcloud.nl/api/v2/'

      # Config
      DEFAULT_OPEN_TIMEOUT = 60
      DEFAULT_TIMEOUT = 120
      SENDCLOUD_API = 'https://panel.sendcloud.sc/api/v2'

      # Resources
      PARCEL_RESOURCE= '/parcels'

      attr_reader :api_endpoint, :api_key, :api_secret, :content_type

      def initialize(api_key = nil, api_secret = nil)
         @api_key          = api_key
         @api_secret       = api_secret
         @options = { :basic_auth => {:username => api_key, :password => api_secret} } 
      end
      
      def get_parcels
         request(:get, PARCEL_RESOURCE)
      end

      def create_parcel(params)
         request(:post, PARCEL_RESOURCE, params)
         # self.class.post(PARCEL_RESOURCE, body: params, basic_auth: auth, headers: {'Content-Type' => 'application/json'})
      end

      def update_parcel(params)
         request(:put, PARCEL_RESOURCE, params)
      end

      def delete_parcel(id)
         request(:post, PARCEL_RESOURCE + id + '/delete')
      end

      private

      def request(method, resource, params = {})
         self.class.public_send(method, PARCEL_RESOURCE, body: params, basic_auth: auth, headers: {'Content-Type' => 'application/json'} )
      end

      # @return [Hash] the basic auth hash based on the api_key and api_secret
      def auth
         { username: api_key, password: api_secret}
      end
   end
end