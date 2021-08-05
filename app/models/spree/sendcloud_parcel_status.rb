module Spree
   class SendcloudParcelStatus < ApplicationRecord
      belongs_to :shipment, class_name: 'Spree::Shipment'

      validates :parcel_status, presence: true
   end
end