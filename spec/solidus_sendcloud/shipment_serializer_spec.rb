describe SendcloudServices::ShipmentSerializer do
   describe "#call" do
      let(:order) { build(:order_ready_to_ship, line_items_count: 2) }

      context "when given a valid shipment" do
         subject(:parcel_payload) { described_class.call(order.shipments.first) }

         it 'returns a valid json payload' do
            expect(JSON.parse(parcel_payload)['parcel']['order_number']).to eq(order.number)
         end
      end

      context "when given an invalid argument" do
         subject(:parcel_payload) { described_class.call({}) }

         it "raises an ArgumentError" do
            expect { parcel_payload }.to raise_error(ArgumentError)
          end
      end
      
   end
end