class FormBuilderController < CmsController
  def index
    @presenter = FormPresenter.new(@obj.crm_activity_type, params[:form_presenter])
    @custom_attributes = @presenter.definition.custom_attributes

    if request.post? && @presenter.submit
      redirect_to(cms_path(@obj), notice: 'The form was sent successfully.')
    end
  end
end
