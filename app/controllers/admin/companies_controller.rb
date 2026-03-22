module Admin
  class CompaniesController < Admin::ApplicationController
    before_action :set_resource, only: %i[edit show update]

    def scoped_resource
      resource_class.order(:id)
    end

    def new
      @resource = new_resource
      authorize_resource(@resource)

      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end

    def edit
      authorize_resource(@resource)

      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end

    def show
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end

    def create
      @resource = new_resource(resource_params)
      authorize_resource(@resource)

      if @resource.save
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_companies_path }
        end
      else
        render :edit, formats: [ :turbo_stream ], status: :unprocessable_entity
      end
    end

    def update
      if @resource.update(resource_params)
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to admin_companies_path }
        end
      else
        render :edit, formats: [ :turbo_stream ], status: :unprocessable_entity
      end
    end

    private

    def set_resource
      @resource = requested_resource
    end
  end
end
