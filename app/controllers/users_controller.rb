class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.order(updated_at: :desc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])

    sounds = @user.sounds.order(updated_at: :desc)

    # @user.sounds.order(:name).limit(10).each do |sound|
    # puts "|||* #{sound.updated_at.inspect} #{sound.name} ||||||"
    # end

    @sounds = sounds.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = I18n.t 'users.welcome'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    User.find(params[:id]).destroy
    flash[:success] = I18n.t 'users.destroy', name: @user.name
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      flash[:success] = I18n.t 'users.update'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    user_para = params.require(:user)
    user_para.permit(:name, :password, :password_confirmation, :admin)
  end
end
