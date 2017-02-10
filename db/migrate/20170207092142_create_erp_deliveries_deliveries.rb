class CreateErpDeliveriesDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_deliveries_deliveries do |t|
      t.string :code
      t.datetime :delivery_date
      t.string :delivery_type
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users
      t.references :order, index: true, references: :erp_sales_orders

      t.timestamps
    end
  end
end
