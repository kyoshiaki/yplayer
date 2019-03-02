require 'audioinfo'

class SoundPlayersController < ApplicationController
  # before_action :verify_user, except: [:fire, :time, :print_time]
  before_action :logged_in_user, only: [:show]

  #
  # PER_PAGE
  #
  PER_PAGE = 30
  # PER_PAGE = 5

  #
  # start_time
  #
  def fire
    @start_time = Time.zone.now
  end

  #
  # time
  #
  def time
    @time = Time.zone.now
  end

  #
  # print_time
  #
  def print_time(message)
    diff = Time.zone.now - @time
    logger.debug "==== #{message} #{diff} (sec) =====\n"
  end

  #
  # show
  #
  def show
    # fire

    @user = User.find(session[:user_id])

    @dirname = params[:dirname]
    @name = params[:name]
    @title = @name
  end
end
