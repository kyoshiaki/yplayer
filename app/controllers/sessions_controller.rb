class SessionsController < ApplicationController
  def new; end

  def login(user)
    log_in user

    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    # redirect_back_or user
    redirect_to directories_show_url
    # remember user
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user&.authenticate(params[:session][:password])
      login(user)
    else
      flash.now[:danger] = I18n.t 'combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
