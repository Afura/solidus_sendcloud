describe SolidusSendcloud::ParcelStatus do
  describe "assosciations" do
    it { should belong_to(:shipment) }
  end

  describe "validations" do
    it{ is_expected.to validate_presence_of :parcel_status }
  end
end