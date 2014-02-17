class ProfilePageController < CmsController
  include Authorization

  def index
    contact = current_user.contact
    attributes = params[:profile_page_presenter] || contact.attributes
    @profile = ProfilePagePresenter.new(attributes)

    if request.post? && @profile.valid?
      # Store form attributes in the CRM.
      contact.update_attributes(@profile.attributes)

      # Refresh the current user because of possible changes to its attributes.
      current_user.refresh

      flash.now[:notice] = 'Your changes have been saved!'
    end
  end
end
