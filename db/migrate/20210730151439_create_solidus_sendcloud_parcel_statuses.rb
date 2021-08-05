class CreateSolidusSendcloudParcelStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :solidus_sendcloud_parcel_statuses do |t|
      t.belongs_to :spree_shipment, index: true, foreign_key: true
      t.integer :status_id
      t.string :status_message

      t.timestamps
    end
  end
endloud