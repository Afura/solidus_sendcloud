module Spree
   module SendcloudSubscriber
      include Spree::Event::Subscriber
   
      event_action :order_finalized
      event_action :order_recalculated
      # event_action :shipment_ready
      # event_action :shipment_resume
      # event_action :shipment_cancel

      # event_action :shipment_updated

      def order_finalized
         binding.pry
      end

      def order_recalculated
         binding.pry
      end
   
      def shipment_ready(event)
         Spree::SendcloudLogger.debug("Sending #{event.payload[:shipment].number} to Sendcloud")
         SendcloudServices::CreateParcel.call(event.payload[:shipment])
      end

      def shipment_resume(event)
         Spree::SendcloudLogger.debug("Sending #{event.payload[:shipment].number} to Sendcloud")
         SendcloudServices::CreateParcel.call(event.payload[:shipment])
      end

      def shipment_updated(event)
         Spree::SendcloudLogger.debug("Updating Sendcloud shipment #{event.payload[:shipment].number}")
         sendcloud_parcel = SendcloudServices::CreateParcel.call(event.payload[:shipment]) if event.payload[:shipment].sendcloud_parcel_id
      end

      def shipment_cancel(event)
         Spree::SendcloudLogger.debug("Cancelling Sendcloud shipment #{event.payload[:shipment].number}")
         SendcloudServices::CancelParcel.call(event.payload[:shipment])
      end

   end
 end