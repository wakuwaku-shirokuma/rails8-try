module Admin
  class CompaniesController < Admin::ApplicationController
    before_action :set_resource, only: %i[edit show update]

    def scoped_resource
      resource_class.order(:id)
    end

    def new
      resource = new_resource
      authorize_resource(resource)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "companies-tbody",
            partial: "admin/companies/form_row",
            locals: { resource: resource }
          )
        end

        format.html
      end
    end

    def edit
      authorize_resource(@resource)

      respond_to do |format|
        format.turbo_stream { render turbo_stream: form_row_stream(@resource) }
        format.html
      end
    end

    def show
      respond_to do |format|
        format.turbo_stream { render turbo_stream: row_stream(@resource) }
        format.html
      end
    end

    def create
      resource = new_resource(resource_params)
      authorize_resource(resource)

      if resource.save
        respond_to do |format|
          format.turbo_stream { render turbo_stream: row_stream(resource, id: "new_company") }
          format.html { redirect_to admin_companies_path }
        end
      else
        render turbo_stream: form_row_stream(resource, id: "new_company"), status: :unprocessable_entity
      end
    end

    def update
      if @resource.update(resource_params)
        respond_to do |format|
          format.turbo_stream { render turbo_stream: row_stream(@resource) }
          format.html { redirect_to admin_companies_path }
        end
      else
        render turbo_stream: form_row_stream(@resource), status: :unprocessable_entity
      end
    end

    private

    def set_resource
      @resource = requested_resource
    end

    def row_stream(resource, id: view_context.dom_id(resource))
      turbo_stream.replace(id, partial: "admin/companies/row", locals: { resource: resource })
    end

    def form_row_stream(resource, id: view_context.dom_id(resource))
      turbo_stream.replace(id, partial: "admin/companies/form_row", locals: { resource: resource })
    end
  end
end
