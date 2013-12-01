class ProfilePageController < CmsController
  include Authorization

  def index
    @presenter = ProfilePagePresenter.new(current_user, params[:profile_page_presenter])

    if request.post? && @presenter.save
      # Refresh the current user because of possible changes to its attributes.
      current_user.refresh

      flash.now[:notice] = I18n.t('flash.profile_page.success')
    end
  end
end
