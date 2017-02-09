module Erp::Deliveries
  class DeliveryDetail < ApplicationRecord
    if Erp::Core.available?("sales")
      belongs_to :order_detail, class_name: "Erp::Sales::OrderDetail"
    end
    belongs_to :delivery, inverse_of: :delivery_details
    validates :delivery, presence: true
  end
end
