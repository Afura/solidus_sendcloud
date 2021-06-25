module SolidusSendcloud
   module Spree
      module ShipmentDecorator

         def self.prepended(base)
            base.after_create do
               Spree::Event.fire 'shipment_created', shipment: self
            end

            base.after_save do
               # TODO: Change to after commit and check for saved_change_to_attribute?
               Spree::Event.fire 'shipment_updated', shipment: self
            end
         end

         # after_cancel > shipment_cancelled
         # after_ship > shipment_shipped
         # after_reader > shipment_ready

         # after_transition to: :ready, do: :after_ready

         private

         def after_ready
            Spree::Event.fire 'shipment_ready', shipment: self
         end

         def after_cancel
            manifest.each { |item| manifest_restock(item) }
            Spree::Event.fire 'shipment_cancelled', shipment: self
         end

         def after_resume
            manifest.each { |item| manifest_unstock(item) }
            Spree::Event.fire 'shipment_resumed', shipment: self
         end

         def after_ship
            order.shipping.ship_shipment(self, suppress_mailer: suppress_mailer)
            Spree::Event.fire 'shipment_shipped', shipment: self
         end
            
         ::Spree::Shipment.prepend self
      end
   end
end