RSpec.describe Spree::SendcloudSubscriber do
  describe 'on shipment_ready' do
    it 'sends the order to the Sendcloud Parcel API' do
      order = build(:order_ready_to_ship)

      perform_subscribers(only: described_class) do
        Spree::Event.fire 'shipment_ready', shipment: order.shipments.first
      end

      # verify the order has been sent to the API
    end
  end
end