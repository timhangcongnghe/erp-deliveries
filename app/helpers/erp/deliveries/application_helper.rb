module Erp
  module Deliveries
    module ApplicationHelper
      
      # Delivery dropdown actions
      def delivery_dropdown_actions(delivery)
        actions = []
        actions << {
          text: '<i class="icon-docs"></i> '+t('.show'),
          url: erp_deliveries.backend_delivery_path(delivery)
        }
        actions << {
          text: '<i class="fa fa-edit"></i> '+t('.edit'),
          url: erp_deliveries.edit_backend_delivery_path(delivery)
        }
        actions << { divider: true }
        actions << {
          text: '<i class="fa fa-trash"></i> '+t('.action_deleted'),
          url: erp_deliveries.status_deleted_backend_deliveries_path(id: delivery),
          data_method: 'PUT',
          class: 'ajax-link',
          data_confirm: t('delete_confirm')
        }        
        erp_datalist_row_actions(
          actions
        )
      end
      
    end
  end
end
