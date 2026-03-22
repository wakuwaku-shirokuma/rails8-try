module Admin
  class CompaniesController < Admin::ApplicationController
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
      resource = requested_resource
      authorize_resource(resource)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            view_context.dom_id(resource),
            partial: "admin/companies/form_row",
            locals: { resource: resource }
          )
        end

        format.html
      end
    end

    def show
      resource = requested_resource

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            view_context.dom_id(resource),
            partial: "admin/companies/row",
            locals: { resource: resource }
          )
        end

        format.html
      end
    end

    def create
      resource = new_resource(resource_params)
      authorize_resource(resource)

      if resource.save
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace(
                "new_company",
                partial: "admin/companies/row",
                locals: { resource: resource }
              )
            ]
          end

          format.html { redirect_to admin_companies_path }
        end
      else
        render turbo_stream: turbo_stream.replace(
          "new_company",
          partial: "admin/companies/form_row",
          locals: { resource: resource }
        ), status: :unprocessable_entity
      end
    end

    def update
      resource = requested_resource

      if resource.update(resource_params)
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
              view_context.dom_id(resource),
              partial: "admin/companies/row",
              locals: { resource: resource }
            )
          end

          format.html { redirect_to admin_companies_path }
        end
      else
        render turbo_stream: turbo_stream.replace(
          view_context.dom_id(resource),
          partial: "admin/companies/form_row",
          locals: { resource: resource }
        ), status: :unprocessable_entity
      end
    end
  end
end
