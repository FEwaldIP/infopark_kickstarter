class LoginPageController < CmsController
  def index
    if request.post?
      if authenticate(user_params[:login], user_params[:password])
        self.current_user = User.new

        target = params[:return_to] || cms_path(@obj.homepage)
        redirect_to(target, notice: 'You logged in successfully.')
      else
        flash[:alert] = 'Log in failed. Please try it again.'
      end
    elsif request.delete?
      self.current_user = nil
      redirect_to(cms_path(@obj.homepage), notice: 'You logged out successfully.')
    end
  end

  private

  def authenticate(login, password)
    login == 'root' && password == 'root'
  end

  def user_params
    params[:user]
  end
end
