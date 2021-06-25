describe SendcloudServices::ShipmentSerializer do
   describe "#serialize_shipment" do
      let(:order) { create(:order_ready_to_complete) }

      subject(:to_json) { described_class.new(order.shipment) }

      it { expect { SendcloudServices::ShipmentSerializer.to_json }.not_to raise_error }
   end
end