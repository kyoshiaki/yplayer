module UsersHelper
  #
  # Confirms a logged-in user.
  #
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = I18n.t 'please_log_in'

    redirect_to login_url
  end

  #
  # Confirms the correct user.
  #
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  #
  # Confirms an admin user.
  #
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
