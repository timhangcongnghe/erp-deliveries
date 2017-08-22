class CreateErpDeliveriesDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_deliveries_deliveries do |t|
      t.string :code
      t.datetime :date
      t.string :delivery_type
      t.string :status, default: "delivered"
      t.boolean :archived, default: false
      t.references :order, index: true, references: :erp_orders_orders
      t.references :warehouse, index: true, references: :erp_warehouses_warehouses
      t.references :contact, index: true, references: :erp_contacts_contacts
      t.references :supplier, index: true, references: :erp_contacts_contacts
      t.references :employee, index: true, references: :erp_users
      t.references :creator, index: true, references: :erp_users
      

      t.timestamps
    end
  end
end
