class RedirectController < CmsController
  def index
    if @obj.redirect_link.present?
      target = cms_path(@obj.redirect_link.first, request.query_parameters)

      redirect_to(target)
    else
      flash.now[:alert] = 'Please configure a redirect target.'
    end
  end
end
