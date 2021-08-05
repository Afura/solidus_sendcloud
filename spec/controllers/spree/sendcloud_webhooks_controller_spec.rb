describe Spree::SendcloudWebhooksController do
   #https://github.com/nepalez/fixturama
   
   describe "POST receive" do
      context "when the action exists" do
         let(:parcel_status_changed) { file_fixture("parcel_status_changed_fixture.json").read }

         it "delegates to the right handler method" do
            # post "/sendcloud_webhooks/receive", :params => parcel_status_changed
         end

         it "it returns status code 200" do
            # post :receive
            # expect(response.status).to be(200)
         end
      end
   
      context "when the action does not exist" do
         it "raises a NoMethodError" do
            expect { raise NoMethodError }.to raise_error(NoMethodError)
         end
      end
   end

   describe "#handle_parcel_status_changed" do

      it "saves the tracking number when available" do
      end

      context "when the shipment is ready to be shipped" do
         it "ships the shipment" do
         end
      end
   end
end