
module Spree
   module ShipmentDecorator

      def self.prepended(base)
         base.has_many :sendcloud_parcel_statuses, :class_name => 'Spree::SendcloudParcelStatus', :foreign_key => "shipment_id"

         # base.state_machine.after_transition(
         #    to: :ready,
         #       do: :after_ready
         #    )

         base.state_machine do
            after_transition do |shipment, transition|
               # binding.pry
               Spree::Event.fire "shipment_#{transition.to_name}", shipment: shipment
            end
         end

         base.after_create do
            Spree::Event.fire 'shipment_created', shipment: self
         end

         base.after_commit do
            # binding.pry
            Spree::Event.fire 'shipment_updated', shipment: self
         end
      end
         
      Spree::Shipment.prepend self
   end
end
