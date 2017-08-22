class CreateErpDeliveriesDeliveryDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_deliveries_delivery_details do |t|
      t.integer :quantity
      t.string :serial_numbers
      t.references :delivery, index: true, references: :erp_deliveries_deliveries
      t.references :order_detail, index: true, references: :erp_orders_order_details

      t.timestamps
    end
  end
end
