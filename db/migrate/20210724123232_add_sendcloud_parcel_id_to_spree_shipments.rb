class AddSendcloudParcelIdToSpreeShipments < SolidusSupport::Migration[6.1]
  def change
    add_column :spree_shipments, :sendcloud_parcel_id, :string
  end
end