module SendcloudServices
   class ShipmentSerializer
    attr_reader :shipment, :order, :address

      def initialize(shipment)
        @shipment = shipment
        @order = shipment.order
        @address = @order.ship_address
      end
  
      def to_json
         {
            parcel: {
              id: shipment.sendcloud_parcel_id
              order_number: order.number,
              external_reference: shipment.number,
              email: order.email,

              name: address.name,
              company_name: address.company,
              address: address.address1,
              address2: address.address2,
              house_number: address.address2,
              city: address.city,
              postal_code: address.zipcode,
              country: address.country.iso,
              telephone: address.phone,

              quantity: shipment.cartons.count,
              weight: shipment_weight,

              parcel_items: line_items,

              customs_invoice_nr: order.number,
              customs_shipment_type: 2,
              total_order_value: shipment.included_tax_total,
              total_order_value_currency: order.currency,

              request_label: false,
            }
          }.to_json
      end

      private

      # Creates an array of line items formatted for Sendcloud parcel_items object.
      #
      # TODO: Not all attributes exist in Solidus by default.
      #
      # @return [Array] array of formatted line items
      def line_items
        @order.line_items.map do |line_item|
          {
            description: line_item.variant.name,
            quantity: line_item.quantity,
            weight: line_item.variant.weight,
            value: line_item.price,
            hs_code: line_item.variant.hs_tarrif_code,
            origin_country: line_item.variant.country_of_manufacture,
            sku: line_item.variant.sku,
            product_id: line_item.variant.id,
            properties: line_item_properties(line_item)
          }
        end
      end

      # Computes the total weight of a shipment.
      #
      # @return [Int] sum of weight as entered per line item * quantity.
      def shipment_weight
        @shipment.line_items.inject(0) do |weight, line_item|
          line_item_weight = line_item.variant.weight
          weight + (line_item_weight ? (line_item.quantity * line_item_weight) : 0)
        end
      end 
  
      # Creates a key value pair out of the variant's (sorted) option values.
      #
      # @return [Hash] string key value pair of option_type and option_value.
      def line_item_properties(line_item)
        values = line_item.variant.option_values.includes(:option_type).sort_by do |option_value|
          option_value.option_type.position
        end

        values.to_a.map! do |option_value|
          {option_value.option_type.presentation => option_value.presentation}
        end
      end

    end
  end
