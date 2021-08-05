module SendcloudServices
   class CreateParcel < ApplicationService
    attr_reader :shipment, :client

    def initialize(shipment)
      raise ArgumentError, 'A valid Spree::Shipment instance is required!' unless shipment.instance_of? Spree::Shipment

      @shipment = shipment
      @client = SendcloudServices::PartyClient.new(SolidusSendcloud.configuration.public_key, SolidusSendcloud.configuration.secret_key)
    end

    def call
      begin
        sendcloud_parcel_payload = SendcloudServices::ShipmentSerializer.call(shipment)

        if !shipment.sendcloud_parcel_id
          response = client.create_parcel(sendcloud_parcel_payload)
          parcel = response.deep_symbolize_keys[:parcel]
          
          shipment.update_columns(
            sendcloud_parcel_id: parcel[:external_order_id],
            tracking: parcel[:tracking_number]
          )

          binding.pry

          Spree::SendcloudLogger.debug("Created Sendcloud order #{shipment.number}")

        else
          response = client.update_parcel(sendcloud_parcel_payload)
          Spree::SendcloudLogger.debug("Updated Sendcloud order #{shipment.number}")
        end

      rescue => error
        OpenStruct.new({success?: false, error: error, response: response})
      else
        OpenStruct.new({success?: true, response: response})
      end
    end
  end
end