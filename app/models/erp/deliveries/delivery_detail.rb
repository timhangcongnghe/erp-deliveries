module Erp::Deliveries
  class DeliveryDetail < ApplicationRecord
    if Erp::Core.available?("orders")
      belongs_to :order_detail, class_name: "Erp::Orders::OrderDetail"
    end
    belongs_to :delivery, inverse_of: :delivery_details
    validates :delivery, presence: true
    
    STATUS_RETURNED = 'returned'
    STATUS_NOT_RETURN = 'not_return'
    STATUS_OVER_RETURED = 'over_returned'
    
    def self.all_active
      self.joins(order_detail: :order).joins(:delivery)
          .where(erp_orders_orders: {status: Erp::Orders::Order::ORDER_STATUS_ACTIVE})
          .where(erp_deliveries_deliveries: {status: Erp::Deliveries::Delivery::DELIVERY_STATUS_ACTIVE})
    end
    
    def self.all_active_import
      self.all_active
          .where(erp_deliveries_deliveries: {delivery_type: Erp::Deliveries::Delivery::TYPE_IMPORT})
    end
    
    def self.all_active_export
      self.all_active
          .where(erp_deliveries_deliveries: {delivery_type: Erp::Deliveries::Delivery::TYPE_EXPORT})
    end
    
    def total
      order_detail.price
    end
    
    def remain_quantity
      get_order_quantity - quantity
    end
    
    def get_ordered_quantity
      order_detail.quantity
    end
    
    def get_delivered_quantity
      order_detail.delivered_quantity
    end
    
    def get_remain_stock
      order_detail.product.stock
    end
    
    def get_stock_status
      order_detail.product.stock_status
    end
    
    def get_product_code
      order_detail.product.code
    end
    
    def get_product_name
      order_detail.product.name
    end
  end
end
