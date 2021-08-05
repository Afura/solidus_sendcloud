module Spree
   class SendcloudWebhooksController < BaseController
      skip_before_action :verify_authenticity_token
      before_action :validate_payload, only: [:receive]

      READY_TO_SHIP = "Ready to send"
      CANCELLED = "Cancelled"
      CANCELLATION_REQUESTED = "Cancellation Requested"
      ANNOUNCED = "Announced"
      NO_LABEL = "No Label"
      ANNOUNCEMENT_FAILED = "Announcement Failed"

      def receive
         # TODO: Use Solidus_Webhooks instead
         begin
           payload = JSON.parse(request.body.read, symbolize_names: true)
           method = "handle_" + payload[:action].tr('.', '_')
           self.send method, payload
         rescue JSON::ParserError => e
           render json: {:status => 400, :error => "Invalid payload"} and return
         rescue NoMethodError => e
         end
         render json: {:status => 200}
      end
      
      def handle_parcel_status_changed(payload)
         # TODO: Guard class and error logging?
         # TODO: Ensure we only change that what needs to be changed
         parcel = payload[:parcel]
         shipment = Spree::Shipment.find_by(sendcloud_parcel_id: parcel[:external_shipment_id])

         if shipment
            shipment.update!(tracking: parcel[:tracking_number]) if parcel[:tracking_number].present?
            shipment.ship! if shipment.can_ship?
         end
      end

      def handle_parcel_status_change(payload)
         # parcel = payload[:parcel]
         # shipment = Spree::Shipment.find_by(sendcloud_parcel_id: parcel[:external_shipment_id]) 

         # SolidusSendcloud::ParcelStatus.create!({
         #    shipment_id: shipment.id,
         #    status_id: payload[:status][:message]
         #    status_message: payload[:status][:message]
         # })

         true
      end

      private

      def validate_payload
         signature = request.headers['Sendcloud-Signature'] || ''
         digest = OpenSSL::Digest.new('sha256')
         expected = OpenSSL::HMAC.hexdigest(digest, SolidusSendcloud.configuration.secret_key, request.body.read)

         head :forbidden unless Rack::Utils.secure_compare(expected, signature)
      end
   end
end