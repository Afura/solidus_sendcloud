module SendcloudServices
   class CancelParcel < ApplicationService
    attr_reader :shipment, :client

    def initialize(shipment)
      @shipment = shipment
      @client = SendcloudServices::PartyClient.new(SolidusSendcloud.configuration.public_key, SolidusSendcloud.configuration.secret_key)
    end

    def call
      begin
        response = client.cancel_parcel(shipment.sendcloud_parcel_id)
        Spree::SendcloudLogger.debug("Cancelled Sendcloud order")
      rescue => error
        OpenStruct.new({success?: false, error: error, response: response})
      else
        OpenStruct.new({success?: true, response: response})
      end
    end
  end
end