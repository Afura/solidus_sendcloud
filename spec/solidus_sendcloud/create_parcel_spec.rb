describe SendcloudServices::CreateParcel do
   describe "#call" do
      let(:order) { build(:order_ready_to_ship, line_items_count: 2) }

      context 'when a valid shipment is provided' do
         # subject(:parcel_payload) { described_class.call(order.shipments.first) }

         # expect(sendcloud_parcel_response).to be_kind_of(Hash)
         # expect(sendcloud_parcel_response).to have_key(:status)
         # expect(sendcloud_parcel_response).to have_key(:data)

         it "saves the Sendcloud parcel id to the shipment" do
         end
      end

      context 'when an invalid shipment is provided' do
         subject(:invalid_parcel_payload) { described_class.call({}) }

         it "raises an error and returns the error messages"
      end
   end
end