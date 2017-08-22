Erp::Deliveries::Engine.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
		namespace :backend, module: "backend", path: "backend/deliveries" do
			resources :deliveries do
				collection do
					post 'list'
					get 'dataselect'
					delete 'delete_all'
					put 'status_deleted'
					put 'status_deleted_all'
					put 'archive'
					put 'unarchive'
					put 'archive_all'
					put 'unarchive_all'
					get 'delivery_details'
				end
			end
			get 'sales_orders' => 'sales#sales_orders', as: :sales_orders
			post 'sales_orders_listing' => 'sales#sales_orders_listing', as: :sales_orders_listing
			get 'sales_order_details' => 'sales#sales_order_details', as: :sales_order_details
		end
	end
end