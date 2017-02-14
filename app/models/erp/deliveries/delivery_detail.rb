module Erp::Deliveries
  class DeliveryDetail < ApplicationRecord
    if Erp::Core.available?("sales")
      belongs_to :order_detail, class_name: "Erp::Sales::OrderDetail"
    end
    belongs_to :delivery, inverse_of: :delivery_details
    validates :delivery, presence: true
    
    def total
      order_detail.price
    end
    
    def get_order_quantity
      order_detail.quantity
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
