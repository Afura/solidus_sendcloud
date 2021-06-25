module Spree
   module SendcloudSubscriber
     include Spree::Event::Subscriber
 
     event_action :shipment_updated
 
     def shipment_updated(event)
        binding.pry
        shipment = event.payload[:shipment]
        sendcloud_parcel = Sendcloud.create_parcel(shipment)
        shipment
     end
   end
 end

 # 1. Checks
 # Check if the order should be send to Sendcloud

 # 2. Create Sendcloud Parcel
 # Send the order to Sendcloud using the API __DONE__
 # Handle the response (Parcel ID)

 # 3. Webhooks
 # Handle webhooks and status changes from Sendcloud