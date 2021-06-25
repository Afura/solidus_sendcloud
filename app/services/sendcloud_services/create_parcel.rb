module SendcloudServices
   class CreateParcel < ApplicationService
      attr_reader :shipment, :order, :address

      def initialize(shipment)
        @shipment = shipment
      end

      def call
        sendcloud_parcel_payload = SendcloudServices::ShipmentSerializer.to_json(shipment)
         
        client = SendcloudServices::Client.new(SolidusSendcloud.configuration.public_key, SolidusSendcloud.configuration.secret_key)

        if !shipment.sendcloud_parcel_id
          response = client.create_parcel(sendcloud_parcel_payload)
        else
          response = client.update_parcel(sendcloud_parcel_payload)
        end

        rescue => error
          OpenStruct.new({success?: false, error: error})
        else
          OpenStruct.new({success?: true, payload: sendcloud_parcel_payload, response: response})
      end
  end
