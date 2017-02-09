require_dependency "erp/backend/backend_controller"

module Erp
  module Deliveries
    module Backend
      class DeliveriesController < Erp::Backend::BackendController
        before_action :set_delivery, only: [:archive, :unarchive, :show, :edit, :update, :destroy]
        before_action :set_deliveries, only: [:delete_all, :archive_all, :unarchive_all]
        
        # GET /deliveries
        def index
        end
        
        # POST /deliveries/list
        def list
          @deliveries = Delivery.search(params).paginate(:page => params[:page], :per_page => 10)
          
          render layout: nil
        end
    
        # GET /deliveries/1
        def show
        end
    
        # GET /deliveries/new
        def new
          @delivery = Delivery.new
          @delivery.delivery_date = Time.now
        end
    
        # GET /deliveries/1/edit
        def edit
        end
    
        # POST /deliveries
        def create
          @delivery = Delivery.new(delivery_params)
          @delivery.creator = current_user
          
          if @delivery.save
            if request.xhr?
              render json: {
                status: 'success',
                text: @delivery.code,
                value: @delivery.id
              }
            else
              redirect_to erp_deliveries.edit_backend_delivery_path(@delivery), notice: t('.success')
            end
          else
            puts @delivery.errors.to_json
            render :new        
          end
        end
    
        # PATCH/PUT /deliveries/1
        def update
          if @delivery.update(delivery_params)
            if request.xhr?
              render json: {
                status: 'success',
                text: @delivery.code,
                value: @delivery.id
              }              
            else
              redirect_to erp_deliveries.edit_backend_delivery_path(@delivery), notice: t('.success')
            end
          else
            render :edit
          end
        end
    
        # DELETE /deliveries/1
        def destroy
          @delivery.destroy

          respond_to do |format|
            format.html { redirect_to erp_deliveries.backend_deliveries_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def archive
          @delivery.archive
          
          respond_to do |format|
            format.html { redirect_to erp_deliveries.backend_deliveries_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        def unarchive
          @delivery.unarchive
          
          respond_to do |format|
            format.html { redirect_to erp_deliveries.backend_deliveries_path, notice: t('.success') }
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end
        end
        
        # DELETE /deliveries/delete_all?ids=1,2,3
        def delete_all         
          @deliveries.destroy_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Archive /deliveries/archive_all?ids=1,2,3
        def archive_all         
          @deliveries.archive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        # Unarchive /deliveries/unarchive_all?ids=1,2,3
        def unarchive_all
          @deliveries.unarchive_all
          
          respond_to do |format|
            format.json {
              render json: {
                'message': t('.success'),
                'type': 'success'
              }
            }
          end          
        end
        
        def dataselect
          respond_to do |format|
            format.json {
              render json: Delivery.dataselect(params[:keyword])
            }
          end
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_delivery
            @delivery = Delivery.find(params[:id])
          end
          
          def set_deliveries
            @deliveries = Delivery.where(id: params[:ids])
          end
    
          # Only allow a trusted parameter "white list" through.
          def delivery_params
            params.fetch(:delivery, {}).permit(:code, :order_id, :delivery_date,
                                            :delivery_details_attributes => [ :id, :order_detail_id, :delivery_id, :quantity, :serial_numbers, :_destroy ])
          end
      end
    end
  end
end
